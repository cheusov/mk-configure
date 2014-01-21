.MAIN: all
.DEFAULT:
	@${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
