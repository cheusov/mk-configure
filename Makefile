.sinclude "cheusov_local_settings.mk" # for debugging

##################################################

MKFILESDIR?=		${PREFIX}/share/mkc-mk
EXTRAFILESDIR?=		${PREFIX}/share/doc/mk-configure
BUILTINSDIR?=		${PREFIX}/share/mk-configure/custom

BMAKE?=			bmake

.if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
AWK?=/usr/xpg4/bin/awk
.else
AWK?=/usr/bin/awk
.endif

##################################################
.PATH:			${.CURDIR}

PROJECTNAME=		mk-configure

VERSION=		0.20.0

BIRTHDATE=		2009-02-21

MKCHECKS=		no

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl \
			mkc_check_prog mkc_check_custom \
			mkc_which mkc_check_version \
			mkc_test_helper mkc_check_compiler \
			mkc_install mkcmake

SCRIPTS+=		${:!cd ${.CURDIR} && echo custom/*!:N*/CVS}

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1 \
			mkc_check_prog.1 mkc_check_custom.1 \
			mk-configure.7 mkcmake.1

EXTRAFILES?=		README NEWS TODO COPYRIGHT FAQ

FILES=	sys.mk configure.mk mkc.configure.mk mkc.mk \
	mkc.own.mk mkc_imp.intexts.mk \
	mkc_check_common.sh \
	mkc.minitest.mk mkc_imp.pkg-config.mk mkc_imp.vars.mk \
	mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.own.mk mkc_imp.prog.mk \
	mkc_imp.subdir.mk mkc_imp.subprj.mk mkc_imp.sys.mk \
	mkc_imp.init.mk mkc_imp.final.mk mkc_imp.scripts.mk \
	mkc_imp.platform.sys.mk mkc_imp.dep.mk mkc_imp.lua.mk \
	mkc_imp.arch.mk mkc_imp.pod.mk

FILES+=			${EXTRAFILES}

.for i in ${EXTRAFILES}
FILESDIR_${i}=		${EXTRAFILESDIR}
.endfor

FILESDIR_mkc_check_common.sh=	${BINDIR}

FILESDIR=			${MKFILESDIR}

.for s in ${SCRIPTS:Mcustom/*}
SCRIPTSDIR_${s:S|/|_|}=		${BUILTINSDIR}
.endfor

SYMLINKS=	mkc.subprj.mk ${MKFILESDIR}/mkc.subprjs.mk
SYMLINKS+=	mkc_imp.pkg-config.mk ${MKFILESDIR}/mkc.pkg-config.mk
SYMLINKS+=	mkc_imp.intexts.mk ${MKFILESDIR}/mkc.intexts.mk

CLEANFILES+=		configure.mk *.cat1 *.html1

INFILES+=		configure.mk mkc_imp.vars.mk
INSCRIPTS+=		mkc_check_version mkcmake
INTEXTS_REPLS+=		version        ${VERSION}
INTEXTS_REPLS+=		AWK            ${AWK}
INTEXTS_REPLS+=		BMAKE          ${BMAKE}
INTEXTS_REPLS+=		mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS+=		syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS+=		mkc_libexecdir ${LIBEXECDIR}

CVSDIST_TARGETS=	doc

INSTALL=		${.CURDIR}/mkc_install

##################################################
.PHONY: doc
doc:
	cd doc && ${MAKE} presentation.pdf clean-garbage ${MAKEFLAGS}

.for i in mkc.prog.mk mkc.lib.mk mkc.subdir.mk mkc.subprj.mk mkc.files.mk
SYMLINKS+=	mkc.mk ${MKFILESDIR}/${i}
CLEANFILES+=	${i}
all: ${i}
${i}:
	ln -f -s mkc.mk ${i}
.endfor

##################################################

.PHONY: test
test: configure.mk mkc_imp.vars.mk mkc_check_version
	@set -e; \
	PATH=${.CURDIR}:${.OBJDIR}:$$PATH; \
	BUILTINSDIR=${.CURDIR}/custom; \
	MKCATPAGES=yes; \
	NO_AUTODEP=yes; \
	export PATH BUILTINSDIR MKCATPAGES NO_AUTODEP; \
	unset MAKEOBJDIR MAKEOBJDIRPREFIX || true; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} ${MAKEFLAGS} test

.PHONY: cleandir_tests clean_tests

cleandir: cleandir_tests
cleandir_tests: configure.mk
	PATH=${.CURDIR}:$$PATH; \
	export PATH; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} \
		${MAKEFLAGS} cleandir
clean: clean_tests
clean_tests: configure.mk
	PATH=${.CURDIR}:$$PATH; \
	export PATH; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} \
		${MAKEFLAGS} clean

##################################################
.include <mkc.mk>
