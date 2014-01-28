PATH.bar  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.bar}
DPLIBDIRS +=	libs/${PATH.bar:T}
LDADD0    +=	-lbar
