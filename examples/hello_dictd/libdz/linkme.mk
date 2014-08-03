PATH.dz :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.dz}
DPLIBDIRS +=	${PATH.dz}
LDADD0    +=	-ldz
