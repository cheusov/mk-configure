FUNCS_RE=(fgetln|progname|strlcat|strlcpy|getline|err|_mkcfake)[.]o

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
	true =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
