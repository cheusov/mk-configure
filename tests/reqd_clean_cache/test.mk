TEST_PREREQS = # empty

.PHONY : test_output
test_output :
	@set -e; LC_ALL=C; export LC_ALL; \
	\
	echo =========== all ============; \
	{ ${MAKE} all 2>&1 >/dev/null | \
	  sed -e 's,using .*-E,using cc -E,' \
	      -e 's,using .*-c,using cc -c,'; \
	  find ${.OBJDIR} -type f -o -type l | sort; } | \
	sed 's,n*b*make\[[0-9]*\],bmake,' | \
	env NOSORT=1 mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
