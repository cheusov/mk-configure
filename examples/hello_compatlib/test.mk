FUNCS_RE=(fgetln|progname|strlcat|strlcpy|getline)[.]o

.PHONY : test_output
test_output :
	@set -e; \
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	grep -vE 'libcmpt/.*[.]os?$$' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	true =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
