PATH.dz :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.dz}
DPLIBDIRS +=	${PATH.dz}
DPLIBS    +=	-ldz
