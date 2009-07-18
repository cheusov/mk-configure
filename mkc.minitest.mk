.PHONY : test
test: test.out
	@printf 'Testing ${.CURDIR}... ' 1>&2; \
	diff ${.CURDIR}/expect.out test.out && \
	echo 'succeeded' 1>&2 || \
	{ echo 'FAILED' 1>&2; false; }
