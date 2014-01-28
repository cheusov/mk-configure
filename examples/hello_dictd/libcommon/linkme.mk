PATH.common :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.common}
DPLIBDIRS +=	${PATH.common}
LDADD0    +=	-lcommon
