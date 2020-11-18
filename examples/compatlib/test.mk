FUNCS_RE=(fgetln|progname|strlcat|strlcpy|getline|err|getdelim|strndup|_mkcfake)[.][do]

.PHONY : test_output
test_output :
	@set -e; \
	echo =========== all ============; \
	{ find ${.OBJDIR} -type f | \
	  LC_ALL=C sort | \
	  grep -Ev '${FUNCS_RE}|prog1/|prog2/'; \
	  echo ===; \
	  find ${.OBJDIR}/prog1 ${.OBJDIR}/prog2 -type f | \
	  LC_ALL=C sort; \
	} | \
	env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo =========== depend ============; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR} -type f | LC_ALL=C sort | \
	grep '[.]d$$' | grep -Ev '${FUNCS_RE}' | \
	env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	echo =========== clean ============; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -v _mkc | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	echo =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
