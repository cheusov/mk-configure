FUNCS_RE=(fgetln|getline|err|progname|strndup)[.]o|custom_attribute

.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/../strlcpy2/input.in; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev ${FUNCS_RE:Q} | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= CLEANFILES ==========; \
	${MAKE} print_values VARS='CLEANFILES' MKCHECKS=no | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o.?$$/) print $$i}'; \
	echo ======= cleandir ==========; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
