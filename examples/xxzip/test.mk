.PHONY : test_output
test_output:
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	${MAKE} ${MAKEFLAGS} all SHRTOUT=yes 2>&1 | \
	mkc_test_helper2; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======== filelist ==========; \
	${MAKE} ${MAKEFLAGS} filelist PREFIX=/usr/local; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}

.include <mkc.minitest.mk>
