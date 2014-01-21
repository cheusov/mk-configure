FUNCS_RE=(strlcat|strlcpy|getline)[.]o

.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/input.in; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	grep -vE '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= CLEANFILES ==========; \
	${MAKE} ${MAKEFLAGS} print-values VARS='CLEANFILES' MKCHECKS=no | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o$$/) print $$i}'

.include <mkc.minitest.mk>
