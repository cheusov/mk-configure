##################################################

PREFIX?=/usr/local
BINDIR?=${PREFIX}/bin
MKFILESDIR?=${PREFIX}/share/mk

##################################################

VERSION=		0.0.1alpha1

BIRTHDATE=		2009-02-20

SCRIPTS=		mk-configure_check_func \
			mk-configure_check_header \
			mk-configure_check_sizeof
FILES=			configure.mk
FILESDIR=		${MKFILESDIR}

.include <bsd.prog.mk>
