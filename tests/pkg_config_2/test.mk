test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} ${MAKEFLAGS} all 2>&1 | \
	grep ERROR: | \
	sed 's/ 2\([.][0-9]*\)*/ 2.NN/' > $$tmp_out || true; \
	if diff ${.CURDIR}/expect.out $$tmp_out; \
	then echo '      succeeded' 1>&2; \
	else echo '      FAILED' 1>&2; ex=1; \
	fi; \
	${MAKE} ${MAKEFLAGS} cleandir 2>&1 | grep ERROR: > $$tmp_out || true; \
	exit $$ex
