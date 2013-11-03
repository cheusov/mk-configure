test:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	{ \
	  ${MAKE} ${MAKEFLAGS} -j3 all 2>&1 | sed -n 2p; \
	  ${MAKE} ${MAKEFLAGS} -j3 all MAKE_VERSION=00000000 2>&1 | sed 's/^.*"bmake/"bmake/'; \
	  echo =========== all ============; \
	  find ${.OBJDIR} -type f -o -type l | \
	  mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	} > $$tmp_out; \
	diff ${.CURDIR}/expect.out $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; ex=1; }; \
	${MAKE} ${MAKEFLAGS} cleandir; \
	exit $$ex
