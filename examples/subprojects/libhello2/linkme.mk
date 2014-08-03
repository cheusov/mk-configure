PATH.hello2 :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.hello2}/include
DPLIBDIRS +=	${PATH.hello2}
LDADD0    +=	-lhello2
