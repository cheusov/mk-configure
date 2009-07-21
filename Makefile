.sinclude "cheusov_local_settings.mk"

##################################################
.PATH:			${.CURDIR}

MKFILESDIR?=		${PREFIX}/share/mk

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.10.0

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1

FILES=			configure.mk mkc.configure.mk mkc.files.mk \
			mkc.info.mk mkc.lib.mk mkc.man.mk mkc.prog.mk \
			mkc.subdir.mk mkc.own.mk mkc.intexts.mk \
			mkc.common.mk mkc_check_common.sh

FILESDIR_mkc_check_common.sh=	${BINDIR}

FILESDIR=		${MKFILESDIR}

CLEANFILES+=		configure.mk *.cat1 *.html1 .error-check

INFILES+=		configure.mk
INTEXTS_SED+=		-e 's,@@version@@,${VERSION},g'

##################################################

.PHONY: test
test: configure.mk
	@set -e; \
	PATH=${.CURDIR}:$$PATH; \
	export PATH; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} ${MAKEFLAGS} test

##################################################
.include <mkc.intexts.mk>
.include <mkc.prog.mk>
