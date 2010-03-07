.PHONY: test_output
test_output:
	@set -e; cd ${.CURDIR}; \
	OPSYS=${OPSYS}; export OPSYS; \
	env CPPFLAGS="${CPPFLAGS} -I${.CURDIR}" ${MAKE} ${MAKEFLAGS} \
		-f mkc_test.mk; \
	echo ===============================; \
	env CPPFLAGS="${CPPFLAGS} -I${.CURDIR}" ${MAKE} ${MAKEFLAGS} \
		-f mkc_test_preset.mk \
		-f mkc_test.mk

.include <mkc.minitest.mk>
.include <mkc.configure.mk>
.include <mkc.prog.mk>
