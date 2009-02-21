##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk
EXECSDIR?=${PREFIX}/libexec/mkc

INST_DIR?=		${INSTALL} -d

##################################################

PROJECTNAME=		mk-configure

VERSION=		0.4.0

BIRTHDATE=		2009-02-21

SCRIPTS=		mkc_check_func mkc_check_header mkc_check_sizeof
SCRIPTSDIR=		${EXECSDIR}

FILES=			configure.mk
FILESDIR=		${MKFILESDIR}

##################################################

.SUFFIXES:  .in

all: configure.mk

.in:
	sed -e 's,@@execsdir@@,${EXECSDIR},g' \
	    -e 's,@@version@@,${VERSION},g' \
	    ${.ALLSRC} > ${.TARGET}

##################################################

clean: clean-local

.PHONY: clean-local
clean-local:
	rm -f configure.mk

# unfortunately bsd.prog.mk doesn't create
# the destinations dirs at installation stage :-(
#install: install-local

.PHONY: install-dirs
install-dirs:
	${INST_DIR} ${DESTDIR}${MKFILESDIR}
	${INST_DIR} ${DESTDIR}${EXECSDIR}

##################################################

.include <bsd.prog.mk>
