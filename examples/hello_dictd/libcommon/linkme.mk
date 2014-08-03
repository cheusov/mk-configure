PATH.common :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.common}
DPLIBDIRS +=	${PATH.common}
LDADD0    +=	-lcommon
