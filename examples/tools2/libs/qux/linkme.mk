PATH.qux  :=	${.PARSEDIR}

CPPFLAGS  +=	-I${OBJDIR_libs_qux}
DPLIBDIRS +=	libs/${PATH.qux:T}
LDADD     +=	-lqux
