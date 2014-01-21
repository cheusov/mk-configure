.MAIN: all
.DEFAULT:
	@FEATURESDIR=${.CURDIR}/features; export FEATURESDIR; \
	${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
