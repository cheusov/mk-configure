next_level !=	expr ${.MAKE.LEVEL} + 1

.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	SRCTOP=`pwd`; export SRCTOP; \
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
	echo SRCDIR_tools_prog1=${SRCDIR_tools_prog1} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_tools_prog2=${SRCDIR_tools_prog2} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_tools_prog3=${SRCDIR_tools_prog3} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_tools_prog4=${SRCDIR_tools_prog4} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_libs_foo=${SRCDIR_libs_foo} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_libs_bar=${SRCDIR_libs_bar} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_prog3=${SRCDIR_prog3} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_bar=${SRCDIR_bar} | sed 's,=.*examples/,=,'; \
	\
	echo =========== check ============; \
	${MAKE} check 2>&1; \
	\
	echo =========== check-tools/prog1 ============; \
	${MAKE} check-tools/prog1 2>&1; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ===== all SHRTOUT=yes ======; \
	${MAKE} clean > /dev/null; \
	env SHRTOUT=YES ${MAKE} all 2>&1; \
	\
	echo ========= installdirs ==========; \
	${MAKE} installdirs DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== clean ===========; \
	${MAKE} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= all-tools/prog1 ==========; \
	${MAKE} configure-tools/prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} -j4 all-tools/prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= -C tools/prog1 all ==========; \
	${MAKE} -j4 clean-tools/prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} -j4 \
		-C `pwd`/tools/prog1 all DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= all-prog1 ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} configure-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} -j4 all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} nodeps-all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} subdir-all-prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} prog1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= all-tools/prog2 ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} configure-tools/prog2 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} -j4 all-tools/prog2 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= -C tools/prog2 all ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} \
		-C tools/prog2 configure DESTDIR=${.OBJDIR} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} -j4 \
		-C tools/prog2 all DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= all-tools/prog3 ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} configure-tools/prog3 DESTDIR=${.OBJDIR} > /dev/null; \
	${MAKE} -j4 all-tools/prog3 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= -C tools/prog4 all ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} \
		-j4 all-tools/prog4 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== print_deps ============; \
	${MAKE} print_deps | grep -E '^(all|[^-/ ]+$$)'; \
	echo =====; \
	${MAKE} print_deps | grep -E ^check; \
	\
	${MAKE} cleandir > /dev/null; \

.include <mkc.minitest.mk>
