CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out

test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} -f ${.CURDIR}/test.mk all 2>&1 | \
	sed 's,n*b*make\[[0-9]*\],bmake,' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q} > $$tmp_out; \
	if diff ${.CURDIR}/expect.out $$tmp_out; then \
		echo '      succeeded' 1>&2; \
	else \
		echo '      FAILED' 1>&2; false; \
	fi

.include <mkc.subprj.mk>
