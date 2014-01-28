PATH.cxxlib :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.cxxlib}/include
DPLIBDIRS +=	${PATH.cxxlib}
LDADD0    +=	-lcxxlib
