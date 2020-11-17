PATH.cxxlib :=	${.PARSEDIR:tA}

DPINCDIRS +=	${PATH.cxxlib}/include
DPLIBDIRS +=	${PATH.cxxlib}
DPLDADD   +=	cxxlib
