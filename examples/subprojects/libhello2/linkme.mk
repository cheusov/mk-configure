PATH.hello2 :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.hello2}/include
DPLIBDIRS +=	${PATH.hello2}
LDADD     +=	-lhello2
