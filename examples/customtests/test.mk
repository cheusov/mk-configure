CLEANDIRS +=		${.CURDIR}/testdir

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== run ============; \
	${.OBJDIR}/hello_customtests | \
	sed 's/alloca(3) succeeded.*$$/alloca(3) succeeded 0xC001BEAF/'; \
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
	echo ======= errorcheck + MAKEOBJDIR ===========; \
	mkdir ${.CURDIR}/testdir || true; \
	${MAKE} ${MAKEFLAGS} errorcheck \
	   MKC_CACHEDIR=${.CURDIR}/testdir \
	   MAKEOBJDIR=${.CURDIR}/testdir > /dev/null; \
	printf 'true_is_available=%s\n' `cat ${.CURDIR}/testdir/_mkc_custom_true_is_available.res`; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}

.include <mkc.minitest.mk>
