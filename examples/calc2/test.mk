.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/calc < ${.CURDIR}/expressions.txt; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== depend ===========; \
	${MAKE} ${MAKEFLAGS} depend -j4 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}

.include <mkc.minitest.mk>
