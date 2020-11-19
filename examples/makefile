# This Makefile is not used by "bmake test".
# It's purpose is to run tests after installing mk-configure.

.sinclude "../examples.mk"

SUBPRJ = ${examples}

# The following is necessary for target "test"
NOEXPORT_VARNAMES= MKC_CACHEDIR SRCTOP OBJTOP

.include <mkc.mk>
