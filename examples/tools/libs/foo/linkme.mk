PATH.foo  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.foo}
DPLIBDIRS +=	${PATH.foo}
LDADD     +=	-lfoo
