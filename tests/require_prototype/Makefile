CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out

test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/test.mk cleandir >/dev/null 2>&1; \
	${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/test.mk all > $$tmp_out 2>&1; \
	diff ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }

.include <mkc.subprj.mk>
