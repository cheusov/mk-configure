next_level !=	expr ${.MAKE.LEVEL} + 1

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
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
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== help =============; \
	${MAKE} ${MAKEFLAGS} help; \
	\
	echo ======== help_subprj ========; \
	${MAKE} ${MAKEFLAGS} help_subprj; \
	\
	echo ======== help_use ========; \
	${MAKE} ${MAKEFLAGS} help_use; \
	\
	echo ========== depend ===========; \
	${MAKE} ${MAKEFLAGS} depend DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= errorcheck ==========; \
	${MAKE} ${MAKEFLAGS} errorcheck > /dev/null 2>&1; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1; \
	\
	echo ==== install MKINSTALL=no ====; \
	MKINSTALL=no; export MKINSTALL; \
	${MAKE} ${MAKEFLAGS} configure DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} all installdirs install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; unset MKINSTALL; \
	\
	echo =========== Michael mode: all ============; \
	MICHAEL_MODE=1; export MICHAEL_MODE; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} all > /dev/null 2>&1; \
	find ${TMPPREFIX} -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== Michael mode: clean ============; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} clean > /dev/null 2>&1; \
	find ${TMPPREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== Michael mode: cleandir ============; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} all > /dev/null 2>&1; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1; \
	find ${TMPPREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	true ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null

CLEANDIRS += ${TMPPREFIX}

.include <mkc.minitest.mk>
