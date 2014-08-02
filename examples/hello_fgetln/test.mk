FUNCS_RE=(fgetln|getline|err|progname)[.]o

.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/../hello_strlcpy2/input.in; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= CLEANFILES ==========; \
	${MAKE} ${MAKEFLAGS} print_values VARS='CLEANFILES' MKCHECKS=no | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o.?$$/) print $$i}'; \
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
