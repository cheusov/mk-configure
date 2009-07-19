.PHONY : test
test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	${MAKE} ${MAKEFLAGS} test_output > $$tmp_out; \
	diff -u ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }
