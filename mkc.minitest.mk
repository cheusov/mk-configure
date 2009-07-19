.PHONY : test
test: ${.OBJDIR}/${.CURDIR:T}.test.out
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	diff -u ${.CURDIR}/expect.out ${.OBJDIR}/${.CURDIR:T}.test.out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }
