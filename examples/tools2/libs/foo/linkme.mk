PATH.foo  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${PATH.foo}
DPLIBDIRS +=	libs/${PATH.foo:T}
LDADD0    +=	-lfoo
