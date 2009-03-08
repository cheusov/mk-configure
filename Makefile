##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk
EXECSDIR?=${PREFIX}/libexec/mkc

INST_DIR?=		${INSTALL} -d

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.6.0

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_funclib mkc_check_header \
			mkc_check_sizeof  mkc_check_decl
SCRIPTSDIR=		${EXECSDIR}

FILES=			configure.mk
FILESDIR=		${MKFILESDIR}

CLEANFILES+=		configure.mk

##################################################

.SUFFIXES:  .in

all: configure.mk

.in:
	sed -e 's,@@execsdir@@,${EXECSDIR},g' \
	    -e 's,@@version@@,${VERSION},g' \
	    ${.ALLSRC} > ${.TARGET}

##################################################

# unfortunately bsd.prog.mk doesn't create
# the destinations dirs at installation stage :-(
#install: install-local
.PHONY: install-dirs
install-dirs:
	${INST_DIR} ${DESTDIR}${MKFILESDIR}
	${INST_DIR} ${DESTDIR}${EXECSDIR}

##################################################

.include <bsd.prog.mk>
