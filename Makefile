##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk

INST_DIR?=		${INSTALL} -d

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.7.0

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl

MAN=			mkc_check_funclib.1 mkc_check_header.1 \
			mkc_check_sizeof.1  mkc_check_decl.1

FILES=			configure.mk
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
	echo $$PATH; \
	if ${.CURDIR}/tests/test.sh > ${.OBJDIR}/_test.res && \
	    diff -u ${.CURDIR}/tests/test.out ${.OBJDIR}/_test.res; \
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
