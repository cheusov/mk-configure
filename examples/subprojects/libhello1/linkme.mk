PATH.hello1 :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.hello1}
DPLIBDIRS +=	${PATH.hello1}
LDADD0    +=	-lhello1
