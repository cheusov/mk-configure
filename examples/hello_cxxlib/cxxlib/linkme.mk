PATH.cxxlib :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.cxxlib}/include
DPLIBDIRS +=	${PATH.cxxlib}
LDADD0    +=	-lcxxlib
