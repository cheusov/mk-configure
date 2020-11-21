CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out

test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/test.mk all 2>&1 | \
	sed 's,n*b*make\[[0-9]*\],bmake,' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" > $$tmp_out; \
	diff ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }

.include <mkc.subprj.mk>
