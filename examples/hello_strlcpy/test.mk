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
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -v 'strlcpy[.]o' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
