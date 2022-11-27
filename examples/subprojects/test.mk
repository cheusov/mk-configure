next_level !=	expr ${.MAKE.LEVEL} + 1

.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo PROJECTNAME=${PROJECTNAME}; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	LD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	LIBRARY_PATH=$$LIBRARY_PATH:$$LD_LIBRARY_PATH; \
	MKINSTALLDIRS=no; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH LIBRARY_PATH; \
	${.CURDIR}/hello/hello_subprojects; \
	${.CURDIR}/hello/hello_subprojects2; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	${MAKE} ${MAKEFLAGS} all SHRTOUT=YES 2>&1 | \
	grep -v warning | \
	mkc_test_helper_paths; \
	\
	echo ========= installdirs ==========; \
	${MAKE} ${MAKEFLAGS} installdirs DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== errorcheck ==========; \
	${MAKE} ${MAKEFLAGS} errorcheck 2> /dev/null 1>&2; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	\
	echo ========= libhello1 ==========; \
	${MAKE} ${MAKEFLAGS} libhello1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-libhello2 ==========; \
	${MAKE} ${MAKEFLAGS} -j4 all-libhello2 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= cleandir-libhello1 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir-libhello1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	\
	echo ======= library dependencies =======; \
	PREFIX=${.CURDIR}/usr; export PREFIX; \
	${MAKE} ${MAKEFLAGS} configure >&2; \
	${MAKE} ${MAKEFLAGS} all -j3 >&2; \
	${MAKE} ${MAKEFLAGS} install -j3 >&2; \
	LD_LIBRARY_PATH=${.CURDIR}/usr/lib; \
	DYLD_LIBRARY_PATH=${.CURDIR}/usr/lib; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${.CURDIR}/usr/bin/hello_subprojects; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
