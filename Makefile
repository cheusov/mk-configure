##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk
EXECSDIR?=${PREFIX}/libexec/mkc

##################################################

VERSION=		0.4.0

BIRTHDATE=		2009-02-20

FILES+=			mkc_check_func mkc_check_header mkc_check_sizeof
FILES+=			configure.mk

FILESDIR=		${EXECSDIR}
FILESDIR.configure.mk=	${MKFILESDIR}

##################################################

.SUFFIXES:  .in

all: configure.mk

.in:
	sed -e 's,@@execsdir@@,${EXECSDIR},g' \
	    -e 's,@@version@@,${VERSION},g' \
	    ${.ALLSRC} > ${.TARGET}

##################################################

.PHONY: clean-local
clean: clean-local
clean-local:
	rm -f configure.mk

.include <bsd.prog.mk>
