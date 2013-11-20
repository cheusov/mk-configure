.sinclude "cheusov_local_settings.mk" # for debugging

##################################################

MKFILESDIR    ?=	${PREFIX}/share/mkc-mk
EXTRAFILESDIR ?=	${PREFIX}/share/doc/mk-configure
BUILTINSDIR   ?=	${PREFIX}/share/mk-configure/custom

BMAKE ?=		bmake

.if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
AWK ?=			/usr/xpg4/bin/awk
.elif exists(/usr/bin/awk)
AWK ?=			/usr/bin/awk
.else
AWK ?=			/bin/awk
.endif

##################################################
.PATH:			${.CURDIR}

SHRTOUT =		yes

PROJECTNAME =		mk-configure

VERSION =		0.24.0

BIRTHDATE =		2009-02-21

_CONFIGURE_MK =		no # configure.mk is not generated yet

SCRIPTS =		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl \
			mkc_check_prog mkc_check_custom \
			mkc_which mkc_check_version \
			mkc_test_helper mkc_check_compiler \
			mkc_install mkcmake

SCRIPTS +=		${:!cd ${.CURDIR} && echo custom/*!:N*/CVS}

MAN =			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1 \
			mkc_check_prog.1 mkc_check_custom.1 \
			mk-configure.7 mkcmake.1

EXTRAFILES ?=		README NEWS TODO COPYRIGHT FAQ

FILES =	sys.mk configure.mk mkc.configure.mk mkc.mk \
	mkc.own.mk mkc_imp.intexts.mk \
	mkc_check_common.sh \
	mkc.minitest.mk mkc_imp.pkg-config.mk mkc_imp.vars.mk \
	mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.own.mk mkc_imp.prog.mk \
	mkc_imp.subprj.mk mkc_imp.sys.mk \
	mkc_imp.init.mk mkc_imp.final.mk mkc_imp.scripts.mk \
	mkc_imp.platform.sys.mk mkc_imp.dep.mk mkc_imp.lua.mk \
	mkc_imp.arch.mk mkc_imp.pod.mk mkc_imp.preinit.mk \
	mkc_imp.objdir.mk mkc_imp.obj.mk

FILES +=		${EXTRAFILES}

.for i in ${EXTRAFILES}
FILESDIR_${i} =		${EXTRAFILESDIR}
.endfor

FILESDIR_mkc_check_common.sh =	${BINDIR}

FILESDIR =			${MKFILESDIR}

.for s in ${SCRIPTS:Mcustom/*}
SCRIPTSDIR_${s:S|/|_|} =	${BUILTINSDIR}
.endfor

SYMLINKS  =	mkc.subprj.mk ${MKFILESDIR}/mkc.subprjs.mk
SYMLINKS +=	mkc_imp.pkg-config.mk ${MKFILESDIR}/mkc.pkg-config.mk
SYMLINKS +=	mkc_imp.intexts.mk ${MKFILESDIR}/mkc.intexts.mk

CLEANFILES +=		configure.mk *.cat1 *.html1 ChangeLog

INFILES       +=	configure.mk mkc_imp.vars.mk mk-configure.7
INSCRIPTS     +=	mkc_check_version mkcmake
INTEXTS_REPLS +=	version        ${VERSION}
INTEXTS_REPLS +=	AWK            ${AWK}
INTEXTS_REPLS +=	BMAKE          ${BMAKE}
INTEXTS_REPLS +=	mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS +=	syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS +=	mkc_libexecdir ${LIBEXECDIR}

DIST_TARGETS =		doc mkc_clean

INSTALL =		${.CURDIR}/mkc_install

##################################################
.PHONY: doc
doc: all
doc:
	cd doc && ${MAKE} -m ${.OBJDIR} presentation.pdf clean-garbage ${MAKEFLAGS}

.for i in mkc.prog.mk mkc.lib.mk mkc.subdir.mk mkc.subprj.mk mkc.files.mk
SYMLINKS   +=	mkc.mk ${MKFILESDIR}/${i}
CLEANFILES +=	${i}
all: ${i}
${i}:
	ln -f -s ${.CURDIR}/mkc.mk ${i}
.endfor

##################################################

.PHONY: test
test: configure.mk mkc_imp.vars.mk mkc_check_version
	@set -e; \
	PATH=${.CURDIR}:${.OBJDIR}:$$PATH; \
	BUILTINSDIR=${.CURDIR}/custom; \
	NO_AUTODEP=yes; \
	export PATH BUILTINSDIR NO_AUTODEP; \
	unset MAKEOBJDIR MAKEOBJDIRPREFIX || true; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} ${MAKEFLAGS} test

.PHONY: cleandir_tests clean_tests

cleandir: cleandir_tests
cleandir_tests: configure.mk
	PATH=${.CURDIR}:$$PATH; \
	export PATH; \
	for d in ${.CURDIR}/tests ${.CURDIR}/doc; do \
	   cd $$d; \
	   ${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} \
		${MAKEFLAGS} cleandir; \
	done
clean: clean_tests
clean_tests: configure.mk
	PATH=${.CURDIR}:$$PATH; \
	export PATH; \
	for d in ${.CURDIR}/tests ${.CURDIR}/doc; do \
	   cd $$d; \
	   ${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} \
		${MAKEFLAGS} clean; \
	done

##################################################
.include <mkc.mk>
