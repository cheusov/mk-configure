.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	env SHRTOUT=YES ${MAKE} ${MAKEFLAGS} all 2>&1 | \
	mkc_test_helper_paths; \
	\
	echo ========= installdirs MKINSTALL=no ==========; \
	env MKINSTALL=no ${MAKE} ${MAKEFLAGS} installdirs \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | grep '${PREFIX}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= install MKINSTALL=no ==========; \
	env MKINSTALL=no ${MAKE} ${MAKEFLAGS} install \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | grep '${PREFIX}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= installdirs ==========; \
	${MAKE} ${MAKEFLAGS} installdirs \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	rm -rf ${.OBJDIR}${PREFIX}; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null

.include <mkc.minitest.mk>