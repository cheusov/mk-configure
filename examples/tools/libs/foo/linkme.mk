PATH.foo  :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.foo}
DPLIBDIRS +=	${PATH.foo}
LDADD0    +=	-lfoo
