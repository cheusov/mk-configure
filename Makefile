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
	true

##################################################

# unfortunately bsd.prog.mk doesn't create
# the destinations dirs at installation stage :-(
#install: install-local
.PHONY: install-dirs
install-dirs:
	${INST_DIR} ${DESTDIR}${MKFILESDIR}
	${INST_DIR} ${DESTDIR}${BINDIR}

##################################################

.include <bsd.prog.mk>
