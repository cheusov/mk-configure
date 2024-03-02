.PHONY : test_output
test_output:
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== vars ============; \
	echo CLEANFILES=${CLEANFILES:Q} | \
	mkc_test_helper_paths; \
	echo CLEANDIRFILES=${CLEANDIRFILES:Q} | \
	mkc_test_helper_paths; \
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} configure > /dev/null; \
	${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== all+html ==========; \
	MKHTML=yes; export MKHTML; \
	${MAKE} ${MAKEFLAGS} configure > /dev/null; \
	${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ==== install MKINSTALL=no ====; \
	MKINSTALL=no; export MKINSTALL; \
	${MAKE} ${MAKEFLAGS} configure DESTDIR=${.OBJDIR} \
		> /dev/null; \
	${MAKE} ${MAKEFLAGS} -j4 all installdirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ==== SHRTOUT=yes ====; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	env MKCATPAGES=no MKHTML=no ${MAKE} ${MAKEFLAGS} SHRTOUT=yes all 2>&1 |\
	mkc_test_helper2; \
	\
	true ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
