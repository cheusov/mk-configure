.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	${MAKE} all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} clean > /dev/null; \
	env ${MAKE} SHRTOUT=YES all 2>&1 | \
	mkc_test_helper_paths; \
	\
	echo ========= installdirs MKINSTALL=no ==========; \
	env MKINSTALL=no ${MAKE} installdirs \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | grep '${PREFIX}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= install MKINSTALL=no ==========; \
	env MKINSTALL=no ${MAKE} install \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | grep '${PREFIX}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= installdirs ==========; \
	${MAKE} installdirs \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ========= install ==========; \
	${MAKE} install \
		DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	rm -rf ${.OBJDIR}${PREFIX}; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null

.include <mkc.minitest.mk>
