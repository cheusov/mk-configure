TEST_PREREQS = # empty

.PHONY : test_output
test_output :
	@set -e; LC_ALL=C; export LC_ALL; \
	\
	echo =========== all ============; \
	{ ${MAKE} ${MAKEFLAGS} all >/dev/null 2>&1 || true; \
	find ${.OBJDIR} -type f -o -type l | sort; } | \
	sed 's,n*b*make\[[0-9]*\],bmake,' | \
	env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
