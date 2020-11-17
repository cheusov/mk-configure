MKC_REQUIRE_BUILTINS +=	prog_gawk prog_flex prog_gm4 prog_bison prog_gmake

SCRIPTS = fake

test: errorcheck
	@echo GNU awk: ${CUSTOM.prog_gawk}; \
	echo GNU m4: ${CUSTOM.prog_gm4}; \
	echo GNU make: ${CUSTOM.prog_gmake}; \
	echo flex: ${CUSTOM.prog_flex}; \
	echo bison: ${CUSTOM.prog_bison}; \
	: =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.prog.mk>
