PATH.qux  :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.qux}
DPLIBDIRS +=	${PATH.qux}
LDADD0    +=	-lqux
