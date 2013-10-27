.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo PROJECTNAME=${PROJECTNAME}; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	${.CURDIR}/tools/prog1/prog1; \
	${.CURDIR}/tools/prog2/prog2; \
	${.CURDIR}/tools/prog3/prog3; \
	${.CURDIR}/tools/prog4/prog4 | sed 's/=[0-9]/=n/'; \
	echo OBJDIR_tools_prog1=${OBJDIR_tools_prog1} | mkc_test_helper_paths; \
	echo OBJDIR_tools_prog2=${OBJDIR_tools_prog2} | mkc_test_helper_paths; \
	echo OBJDIR_tools_prog3=${OBJDIR_tools_prog3} | mkc_test_helper_paths; \
	echo OBJDIR_tools_prog4=${OBJDIR_tools_prog4} | mkc_test_helper_paths; \
	echo OBJDIR_libs_foo=${OBJDIR_libs_foo} | mkc_test_helper_paths; \
	echo OBJDIR_libs_bar=${OBJDIR_libs_bar} | mkc_test_helper_paths; \
	echo OBJDIR_prog3=${OBJDIR_prog3} | mkc_test_helper_paths; \
	echo OBJDIR_bar=${OBJDIR_bar} | mkc_test_helper_paths; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	env SHRTOUT=YES \
		${MAKE} ${MAKEFLAGS} all 2>&1; \
	\
	echo ========= installdirs ==========; \
	${MAKE} ${MAKEFLAGS} installdirs DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-tools/prog1 ==========; \
	${MAKE} ${MAKEFLAGS} all-tools/prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-prog1 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} nodeps-all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} subdir-all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-tools/prog2 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} all-tools/prog2 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-tools/prog3 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} all-tools/prog3 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-tools/prog4 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} ${MAKEFLAGS} all-tools/prog4 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \

.include <mkc.minitest.mk>
