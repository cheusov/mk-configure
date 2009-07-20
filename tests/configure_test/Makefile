.PHONY: test_output
test_output:
	@env CPPFLAGS="${CPPFLAGS} -I." ${MAKE} ${MAKEFLAGS} \
		-f mkc_test.mk; \
	echo ===============================; \
	env CPPFLAGS="${CPPFLAGS} -I." ${MAKE} ${MAKEFLAGS} \
		-f mkc_test_preset.mk \
		-f mkc_test.mk

.include <mkc.minitest.mk>
