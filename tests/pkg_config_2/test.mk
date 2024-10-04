test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} all 2>&1 | \
	awk '/ERROR:/ && !/has version/ {print $$1}' | uniq > $$tmp_out || true; \
	if diff ${.CURDIR}/expect.out $$tmp_out; \
	then echo '      succeeded' 1>&2; \
	else echo '      FAILED' 1>&2; ex=1; \
	fi; \
	${MAKE} cleandir 2>&1 | grep ERROR: > $$tmp_out || true; \
	exit $$ex

CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out
