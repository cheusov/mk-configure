PATH.cxxlib :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.cxxlib}/include
DPLIBDIRS +=	${PATH.cxxlib}
DPLIBS    +=	-lcxxlib
