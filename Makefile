.MAIN: all
.DEFAULT:
	@unset ROOT_GROUP; ${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
