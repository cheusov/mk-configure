EXCL_RE='autom4te[.]cache'

.PHONY : test_output
test_output:
	@ \
	${.OBJDIR}/proj/hello_autotools; \
	rm -rf ${.OBJDIR}/proj${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR}/proj -type f | grep -Ev '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 \
		DESTDIR=${.OBJDIR}/proj > /dev/null; \
	find ${.OBJDIR}/proj${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall \
		DESTDIR=${.OBJDIR}/proj > /dev/null; \
	find ${.OBJDIR}/proj${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR:Q}; \
	\
	echo ========== clean ===========; \
	${MAKE} clean > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR:Q}; \
	\
	echo ========== all SHRTOUT=yes ===========; \
	${MAKE} all SHRTOUT=yes | grep -v 'loading site script' | \
	grep -E '^[[:alpha:]]+:'; \
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR:Q}

.include <mkc.minitest.mk>
