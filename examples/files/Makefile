STRANGEDIR1 ?=		${PREFIX}/share/files1
STRANGEDIR2 ?=		${PREFIX}/share/files2
STRANGEDIR3 ?=		${PREFIX}/share/files3

FILES =		shell_func1 shell_func2 shell_func3

FILESDIR =		${BINDIR}
FILESDIR_shell_func3 =	${LIBEXECDIR}

LINKS  =		${BINDIR}/shell_func1 ${STRANGEDIR1}/shell_func1.sh
LINKS +=		${BINDIR}/shell_func2 ${STRANGEDIR2}/shell_func2.sh

SYMLINKS =		${LIBEXECDIR}/shell_func3 ${STRANGEDIR3}/shell_func3.sh

MAN =			shell_func.7
TEXINFO =		shell_func.texinfo # for .info file

# The following line is for regression test only.
# We will not create and update dir file
INSTALL_INFO =		:

# The following lines are for regression test only.
# We will build .html from man page only under NetBSD
OPSYS !=		uname -s
.if ${OPSYS} != "NetBSD"
MKHTML =		no
.endif

MKC_REQD =		0.11.0

.include "test.mk"
.include <mkc.files.mk>
