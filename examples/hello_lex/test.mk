.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello_lex < ${.CURDIR}/input.txt; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== depend ===========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	${MAKE} ${MAKEFLAGS} depend -j4 > /dev/null 2>&1; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ==== SHRTOUT=yes depend ====; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	env ${MAKE} ${MAKEFLAGS} SHRTOUT=yes depend 2>/dev/null |\
	mkc_test_helper2; \
	\
	echo ==== SHRTOUT=yes all ====; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	env MKCATPAGES=no MKHTML=no ${MAKE} ${MAKEFLAGS} all SHRTOUT=yes 2>&1 |\
	mkc_test_helper2; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
