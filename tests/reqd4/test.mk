CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out

test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	${MAKE} ${MAKEFLAGS} cleandir; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	{ \
	  ${MAKE} ${MAKEFLAGS} -j3 all MKC_REQD=999.0.0 2>&1 | \
	  grep ERROR: | \
	  sed -e 's/ [0-9][0-9]*[.][0-9][0-9]*[.][0-9][0-9]*/ N.N.N/' \
		-e 's/^.* line[^"]*"//' -e 's/".*//'; \
	  ${MAKE} ${MAKEFLAGS} -j3 all MAKE_VERSION=00000000 2>&1 | \
	  grep ERROR: | \
	  sed -e 's/^.*"bmake/"bmake/' -e 's/^.* line[^"]*"//' -e 's/".*//'; \
	  echo =========== all ============; \
	  find ${.OBJDIR} -type f -o -type l | \
	  mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	} > $$tmp_out; \
	diff ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; ex=1; }; \
	${MAKE} ${MAKEFLAGS} cleandir; \
	exit $$ex
