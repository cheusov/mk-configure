PATH.maa :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.maa}
DPLIBDIRS +=	${PATH.maa}
LDADD0    +=	-lmaa
