PATH.qux  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.qux}
DPLIBDIRS +=	libs/${PATH.qux:T}
LDADD     +=	-lqux
