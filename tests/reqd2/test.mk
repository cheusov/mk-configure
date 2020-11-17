test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -f $$tmp_out; \
	${MAKE} ${MAKEFLAGS} all MKC_REQD=999.0.0 2>&1 | head -1 | \
	sed -e 's/ [0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*/ N.N.N/' \
		-e 's/^.* line[^"]*"//' -e 's/".*//' > $$tmp_out; \
	diff ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }
