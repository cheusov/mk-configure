PATH.foo  :=	${.PARSEDIR:tA}

CPPFLAGS  +=	-I${PATH.foo}
DPLIBDIRS +=	libs/${PATH.foo:T}
LDADD0    +=	-lfoo
