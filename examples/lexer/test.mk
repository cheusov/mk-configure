.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/lexer < ${.CURDIR}/input.txt; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -v '_mkc_funclib_yywrap_fl' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== clean ===========; \
	${MAKE} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -v '_mkc_funclib_yywrap_fl' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== depend ===========; \
	${MAKE} cleandir > /dev/null; \
	${MAKE} depend -j4 > /dev/null 2>&1; \
	find ${.OBJDIR} -type f | grep -v '_mkc_funclib_yywrap_fl' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ==== SHRTOUT=yes depend ====; \
	${MAKE} cleandir > /dev/null; \
	env ${MAKE} SHRTOUT=yes depend 2>/dev/null |\
	mkc_test_helper2; \
	\
	echo ==== SHRTOUT=yes all ====; \
	${MAKE} clean > /dev/null; \
	env MKCATPAGES=no MKHTML=no ${MAKE} all SHRTOUT=yes 2>&1 |\
	mkc_test_helper2; \
	find ${.OBJDIR} -type f | grep -v '_mkc_funclib_yywrap_fl' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}

.include <mkc.minitest.mk>
