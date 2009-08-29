FILES=			shell_func1 shell_func2 shell_func3

FILESDIR=		${BINDIR}
FILESDIR_shell_func3=	${LIBEXECDIR}

LINKS+=			${BINDIR}/shell_func1 ${BINDIR}/shell_func1.sh
LINKS+=			${BINDIR}/shell_func2 ${BINDIR}/shell_func2.sh

SYMLINKS+=		${LIBEXECDIR}/shell_func3 ${LIBEXECDIR}/shell_func3.sh

MAN=			shell_func.7

.include "test.mk"
.include <mkc.prog.mk>
