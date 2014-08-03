PATH.bar  :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.bar}
DPLIBDIRS +=	${PATH.bar}
LDADD0    +=	-lbar
