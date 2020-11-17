PATH.baz :=	${.PARSEDIR:tA}

DPINCDIRS +=	${PATH.baz}/include # non-default dir for headers
DPLIBDIRS +=	${OBJDIR_libs_libbaz}
DPLDADD   +=	bazbaz # non-default library name
