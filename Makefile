##################################################

PREFIX?=		/usr/local
BINDIR?=		${PREFIX}/bin
MANDIR?=		${PREFIX}/man
MKFILESDIR?=		${PREFIX}/share/mk

INST_DIR?=		${INSTALL} -d

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.8beta1

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1

FILES=			configure.mk mkc.configure.mk mkc.files.mk \
			mkc.info.mk mkc.lib.mk mkc.man.mk mkc.prog.mk \
			mkc.subdir.mk mkc.own.mk \
			_mkc.common.mk mkc_check_common.sh
FILESDIR_mkc_check_common.sh=	${BINDIR}

FILESDIR=		${MKFILESDIR}

CLEANFILES+=		configure.mk

##################################################

.SUFFIXES:  .in

all: configure.mk

.in:
	sed -e 's,@@version@@,${VERSION},g' \
	    ${.ALLSRC} > ${.TARGET}

.PHONY: test
test: configure.mk
	@echo 'running tests...'; \
	OBJDIR=${.OBJDIR}; \
	MAKE='${MAKE}'; \
	SRCDIR=${.CURDIR}; \
	PATH=${.CURDIR}:$$PATH; \
	MAKEOBJDIR=${.OBJDIR}; \
	export OBJDIR MAKE SRCDIR PATH MAKEOBJDIR; \
	if ${.CURDIR}/tests/test.sh; \
	then echo '   succeeded'; \
	else echo '   failed'; false; \
	fi

##################################################

# unfortunately bsd.prog.mk doesn't create
# the destinations dirs at installation stage :-(
#install: install-local
.PHONY: install-dirs
install-dirs:
	${INST_DIR} ${DESTDIR}${MKFILESDIR}
	${INST_DIR} ${DESTDIR}${BINDIR}
.if !defined(MKMAN) || empty(MKMAN:M[Nn][Oo])
	$(INST_DIR) ${DESTDIR}${MANDIR}/man1
.if !defined(MKCATPAGES) || empty(MKCATPAGES:M[Nn][Oo])
	$(INST_DIR) ${DESTDIR}${MANDIR}/cat1
.endif
.endif

##################################################

.include <bsd.prog.mk>
