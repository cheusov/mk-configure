##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk

##################################################

VERSION=		0.0.1alpha1

BIRTHDATE=		2009-02-20

SCRIPTS=		mkc_check_func \
			mkc_check_header \
			mkc_check_sizeof
FILES=			configure.mk
FILESDIR=		${MKFILESDIR}

.include <bsd.prog.mk>
