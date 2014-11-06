OPT_FLAG ?=	-Os

MKC_CHECK_CXX_OPTS =	${OPT_FLAG}
MKC_CHECK_CC_OPTS =	${OPT_FLAG}

.include <mkc.configure.mk>

.if ${HAVE_CXX_OPT.${OPT_FLAG}:U0}
CXXFLAGS +=	${OPT_FLAG}
.endif
