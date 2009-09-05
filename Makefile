.sinclude "cheusov_local_settings.mk" # for debugging

##################################################
.PATH:			${.CURDIR}

MKFILESDIR?=		${PREFIX}/share/mk
EXTRAFILESDIR?=		${PREFIX}/share/doc/mk-configure

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.10.999

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl \
			mkc_check_prog mkc_which mkc_check_version
#SCRIPTSDIR_mkc_which=		${LIBEXECDIR}/mkc
#SCRIPTSDIR_mkc_check_version=	${LIBEXECDIR}/mkc

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1 \
			mkc_check_prog.1

EXTRAFILES?=		README NEWS TODO COPYRIGHT FAQ
FILES=			configure.mk mkc.configure.mk mkc.files.mk \
			mkc.lib.mk mkc.prog.mk \
			mkc.subdir.mk mkc.own.mk mkc.intexts.mk \
			mkc.common.mk mkc_check_common.sh \
			mkc.minitest.mk mkc.pkg-config.mk _mkc.ver.mk \
			_mkc.missedfiles.mk

FILES+=			${EXTRAFILES}

.for i in ${EXTRAFILES}
FILESDIR_${i}=		${EXTRAFILESDIR}
.endfor

FILESDIR_mkc_check_common.sh=	${BINDIR}

FILESDIR=		${MKFILESDIR}

CLEANFILES+=		configure.mk *.cat1 *.html1 .error-check

INFILES+=		configure.mk _mkc.ver.mk
INTEXTS_SED+=		-e 's,@@version@@,${VERSION},g'

##################################################

.PHONY: test
test: configure.mk
	@set -e; \
	PATH=${.CURDIR}:$$PATH; \
	MKCATPAGES=no; \
	NO_AUTODEP=yes; \
	export PATH MKCATPAGES NO_AUTODEP; \
	cd ${.CURDIR}/tests; \
	${MAKE} -m ${.CURDIR} -m ${.OBJDIR} -m ${MKFILESDIR} ${MAKEFLAGS} test

##################################################
.include <mkc.intexts.mk>
.include <mkc.prog.mk>
