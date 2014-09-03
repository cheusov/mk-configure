next_level !=	expr ${.MAKE.LEVEL} + 1

run_nm := env NM=${NM:Q} OPSYS=${OPSTS:Q} mkc_test_nm

.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	SRCTOP=`pwd`; export SRCTOP; \
	\
	rm -rf ${.OBJDIR}${PREFIX}; \
	LD_LIBRARY_PATH=${.CURDIR}/libdz:${.CURDIR}/libmaa:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${.CURDIR}/libdz:${.CURDIR}/libmaa:$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${.CURDIR}/dict/dict; \
	${.CURDIR}/dictd/dictd; \
	${.CURDIR}/dictfmt/dictfmt; \
	${.CURDIR}/dictzip/dictzip; \
	\
	echo =========== nm ============; \
	case ${OPSYS} in \
	  *BSD|DragonFly|SunOS|Linux) \
	    ${run_nm} ${OBJDIR_libmaa}/libmaa*.so; \
	    echo =; \
	    ${run_nm} ${OBJDIR_libdz}/libdz*.so;; \
	  *) \
	    printf 'symbol fake4\nsymbol fake5\nsymbol fake6\n=\nsymbol fake3\n';; \
	esac; \
	\
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= installdirs ==========; \
	${MAKE} ${MAKEFLAGS} installdirs DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== nodeps-cleandir-dictfmt subdir-clean-dictzip ===========; \
	${MAKE} ${MAKEFLAGS} nodeps-cleandir-dictfmt nodeps-clean-dictzip > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}${PREFIX} ${.OBJDIR}/usr ${.OBJDIR}/home ${.OBJDIR}/Users; \
	echo =========== MKOBJDIRS=auto ============; \
	env TARGETS=fake ${MAKE} ${MAKEFLAGS} fake \
		MKCHECKS=no MAKEOBJDIRPREFIX=${.OBJDIR}/obj1 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep -v obj1 | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	echo ===; \
	find ${.OBJDIR}/obj1/${.OBJDIR} -type d -o -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; rm -rf obj1; \
	\
	echo =========== MKOBJDIRS=yes ============; \
	env TARGETS=fake ${MAKE} ${MAKEFLAGS} fake \
		MKCHECKS=no MKOBJDIRS=yes MAKEOBJDIRPREFIX=${.OBJDIR}/obj1 > /dev/null; \
	printf '%s' 'obj1 '; \
	if test -d ${.OBJDIR}/obj1; then echo exists; else echo does not exist; fi; \
	rm -rf obj1; \
	echo ===; \
	${MAKE} ${MAKEFLAGS} obj MKOBJDIRS=yes MAKEOBJDIRPREFIX=${.OBJDIR}/obj2 > /dev/null; \
	${MAKE} ${MAKEFLAGS} obj MKOBJDIRS=yes MAKEOBJDIR=${.OBJDIR}/obj3 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep -v 'obj[23]' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	echo ===; \
	find ${.OBJDIR}/obj2/${.OBJDIR} ${.OBJDIR}/obj3 \
	   -type d -o -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; rm -rf obj2 obj3; \
	\
	echo =========== MKOBJDIRS=no ============; \
	${MAKE} ${MAKEFLAGS} obj MKOBJDIRS=no MAKEOBJDIRPREFIX=${.OBJDIR}/obj2 > /dev/null; \
	${MAKE} ${MAKEFLAGS} obj MKOBJDIRS=no MAKEOBJDIR=${.OBJDIR}/obj3 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep 'obj[23]' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; rm -rf obj2 obj3; \
	\
	echo ======= errorcheck ==========; \
	${MAKE} ${MAKEFLAGS} errorcheck > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	\
	echo ======= all-dict ==========; \
	${MAKE} ${MAKEFLAGS} -j4 all-dict > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= -C dict all ==========; \
	${MAKE} ${MAKEFLAGS} clean-dict > /dev/null; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} -C dict all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========= installdirs-dict ==========; \
	${MAKE} ${MAKEFLAGS} installdirs-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install-dict ==========; \
	${MAKE} ${MAKEFLAGS} install-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= -Cdict install ==========; \
	rm -rf ${.OBJDIR}${PREFIX} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} -C dict install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= uninstall-dict ==========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== -C dict clean ===========; \
	env init_make_level=${next_level} ${MAKE} ${MAKEFLAGS} -C dict clean > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= cleandir-dict ==========; \
	${MAKE} ${MAKEFLAGS} cleandir-dict > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= installdirs-doc ==========; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	${MAKE} ${MAKEFLAGS} installdirs-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install-doc ==========; \
	${MAKE} ${MAKEFLAGS} install-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= uninstall-doc ==========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo =========== all with NOSUBDIR ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	NOSUBDIR='dictfmt dictzip'; export NOSUBDIR; \
	${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	unset NOSUBDIR; \
	\
	echo =========== all with MKPIE=yes ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	${MAKE} ${MAKEFLAGS} -j4 all MKPIE=yes > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo =========== all with STATICLIBS=everything... ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	env STATICLIBS='libmaa libdz' ${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo =========== print_deps ============; \
	${MAKE} ${MAKEFLAGS} print_deps | grep -E '^(all|test)'; \
	echo =====; \
	NOSUBDIR='dictfmt dictzip' \
	   ${MAKE} ${MAKEFLAGS} print_deps | grep -E '^(all|test)'; \
	echo =====; \
	NODEPS='test2-*:test2-dict*' TARGETS=test2 \
	   ${MAKE} ${MAKEFLAGS} print_deps | grep -E '^(all|test)'; \
	\
	true =========== cleandir ============; \
	unset NOSUBDIR || true; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
