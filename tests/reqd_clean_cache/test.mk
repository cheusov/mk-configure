TEST_PREREQS = # empty

.PHONY : test_output
test_output :
	@set -e; \
	\
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} all || true > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | \
	sed 's,^.*/tests/,tests/,'; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
