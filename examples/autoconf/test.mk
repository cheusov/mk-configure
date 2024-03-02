EXCL_RE='autom4te[.]cache'

.PHONY : test_output
test_output:
	@ \
	${.OBJDIR}/proj/hello_autoconf; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR}/proj -type f | grep -Ev '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR}; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR}; \
	\
	echo ========== all SHRTOUT=yes ===========; \
	${MAKE} ${MAKEFLAGS} all SHRTOUT=yes | grep -v 'loading site script' | \
	grep -E '^[[:alpha:]]+:'; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q}/proj ${.CURDIR}

.include <mkc.minitest.mk>
