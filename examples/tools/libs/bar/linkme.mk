PATH.bar  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.bar}
DPLIBDIRS +=	${PATH.bar}
LDADD     +=	-lbar
