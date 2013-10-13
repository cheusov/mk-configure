.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/input.in; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= CLEANFILES ==========; \
	${MAKE} ${MAKEFLAGS} print-values VARS='CLEANFILES' MKCHECKS=no | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o$$/) print $$i}'

.include <mkc.minitest.mk>
