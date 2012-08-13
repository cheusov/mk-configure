PATH.common :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.common}
DPLIBDIRS +=	${PATH.common}
LDADD     +=	-lcommon
