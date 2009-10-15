.sinclude "cheusov_local_settings.mk" # for debugging

##################################################
.PATH:			${.CURDIR}

MKFILESDIR?=		${PREFIX}/share/mk
EXTRAFILESDIR?=		${PREFIX}/share/doc/mk-configure

##################################################

.if exists(/usr/xpg4/bin/awk)
AWK?=/usr/xpg4/bin/awk
.else
AWK?=/usr/bin/awk
.endif

PROJECTNAME=		mk-configure

VERSION=		0.11.5

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl \
			mkc_check_prog mkc_check_custom \
			mkc_which mkc_check_version \
			mkc_test_helper

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1 \
			mkc_check_prog.1 \
			mk-configure.7

EXTRAFILES?=		README NEWS TODO COPYRIGHT FAQ
FILES=			configure.mk mkc.configure.mk mkc.files.mk \
			mkc.lib.mk mkc.prog.mk \
			mkc.subdir.mk mkc.own.mk mkc.intexts.mk \
			mkc_check_common.sh \
			mkc.minitest.mk mkc.pkg-config.mk mkc.ver.mk
FILES+= mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.own.mk mkc_imp.prog.mk \
	mkc_imp.subdir.mk mkc_imp.sys.mk mkc_imp.init.mk \
	mkc_imp.platform.sys.mk

FILES+=			${EXTRAFILES}

.for i in ${EXTRAFILES}
FILESDIR_${i}=		${EXTRAFILESDIR}
.endfor

FILESDIR_mkc_check_common.sh=	${BINDIR}

FILESDIR=		${MKFILESDIR}

CLEANFILES+=		configure.mk *.cat1 *.html1

INFILES+=		configure.mk mkc.ver.mk
INSCRIPTS+=		mkc_check_version
INTEXTS_SED+=		-e 's,@@version@@,${VERSION},g'
INTEXTS_SED+=		-e 's,@AWK@,${AWK},g'

##################################################

.PHONY: test
test: configure.mk mkc.ver.mk mkc_check_version
	@set -e; \
	PATH=${.CURDIR}:${.OBJDIR}:$$PATH; \
	MKCATPAGES=yes; \
	NO_AUTODEP=yes; \
	export PATH MKCATPAGES NO_AUTODEP; \
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
.include <mkc.intexts.mk>
.include <mkc.prog.mk>
