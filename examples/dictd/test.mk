next_level !=	expr ${.MAKE.LEVEL} + 1

run_nm := env NM=${NM:Q} OPSYS=${OPSYS:Q} mkc_test_nm

.PHONY : test_output
test_output :
	@set -e; \
	MKCATPAGES=yes; export MKCATPAGES; \
	SRCTOP=`pwd`; export SRCTOP; \
	\
	rm -rf ${.OBJDIR}${PREFIX}; \
	LD_LIBRARY_PATH=${.CURDIR}/libdz:${.CURDIR}/libmaa:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${.CURDIR}/libdz:${.CURDIR}/libmaa:$$LD_LIBRARY_PATH; \
	LIBRARY_PATH=$$LIBRARY_PATH:$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH LIBRARY_PATH; \
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
	${MAKE} configure > /dev/null; \
	${MAKE} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= INTERNALLIBS ==========; \
	{ ${MAKE} installdirs DESTDIR=${.OBJDIR}; \
	  ${MAKE} install DESTDIR=${.OBJDIR}; \
	  ${MAKE} uninstall DESTDIR=${.OBJDIR}; \
	} 2>&1 | \
	awk '/^(un)?install/ {sub(/(examples\/)?dictd\//, ""); print $0}'; \
	rm -rf ${.OBJDIR}/`echo ${PREFIX} | cut -d/ -f2`; \
	echo ========= installdirs ==========; \
	${MAKE} installdirs DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== nodeps-cleandir-dictfmt subdir-clean-dictzip ===========; \
	${MAKE} nodeps-cleandir-dictfmt nodeps-clean-dictzip > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== clean ===========; \
	${MAKE} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf ${.OBJDIR}/`echo ${PREFIX} | cut -d/ -f2`; \
	echo =========== MKOBJDIRS=auto ============; \
	env TARGETS=fake ${MAKE} fake \
		MKCHECKS=no MAKEOBJDIRPREFIX=${.OBJDIR}/obj1 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep -v obj1 | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	echo ===; \
	find ${.OBJDIR}/obj1${.OBJDIR} -type d -o -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; rm -rf obj1; \
	\
	echo =========== MKOBJDIRS=yes ============; \
	env TARGETS=fake ${MAKE} fake \
		MKCHECKS=no MKOBJDIRS=yes MAKEOBJDIRPREFIX=${.OBJDIR}/obj1 > /dev/null; \
	printf '%s' 'obj1 '; \
	if test -d ${.OBJDIR}/obj1; then echo exists; else echo does not exist; fi; \
	rm -rf obj1; \
	echo ===; \
	${MAKE} obj MKOBJDIRS=yes MAKEOBJDIRPREFIX=${.OBJDIR}/obj2 > /dev/null; \
	${MAKE} obj MKOBJDIRS=yes MAKEOBJDIR=${.OBJDIR}/obj3 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep -v 'obj[23]' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	echo ===; \
	find ${.OBJDIR}/obj2${.OBJDIR} ${.OBJDIR}/obj3 \
	   -type d -o -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; rm -rf obj2 obj3; \
	\
	echo =========== MKOBJDIRS=no ============; \
	${MAKE} obj MKOBJDIRS=no MAKEOBJDIRPREFIX=${.OBJDIR}/obj2 > /dev/null; \
	${MAKE} obj MKOBJDIRS=no MAKEOBJDIR=${.OBJDIR}/obj3 > /dev/null; \
	find ${.OBJDIR} -type d -o -type f -o -type l | grep 'obj[23]' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; rm -rf obj2 obj3; \
	\
	echo ======= errorcheck ==========; \
	${MAKE} errorcheck > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	${MAKE} cleandir > /dev/null; \
	\
	echo ======= all-dict ==========; \
	${MAKE} configure-dict > /dev/null; \
	${MAKE} -j4 all-dict > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= -C dict all ==========; \
	${MAKE} clean-dict > /dev/null; \
	env init_make_level=${next_level} ${MAKE} -C dict all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========= installdirs-dict ==========; \
	${MAKE} installdirs-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install-dict ==========; \
	${MAKE} install-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= -Cdict install ==========; \
	rm -rf ${.OBJDIR}${PREFIX} > /dev/null; \
	env init_make_level=${next_level} ${MAKE} -C dict install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= uninstall-dict ==========; \
	${MAKE} -j4 uninstall-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ========== -C dict clean ===========; \
	env init_make_level=${next_level} ${MAKE} -C dict clean > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q};\
	\
	echo ======= cleandir-dict ==========; \
	${MAKE} cleandir-dict > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= installdirs-doc ==========; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	${MAKE} installdirs-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install-doc ==========; \
	${MAKE} install-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= uninstall-doc ==========; \
	${MAKE} -j4 uninstall-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== all with NOSUBDIR ============; \
	${MAKE} cleandir > /dev/null; \
	NOSUBDIR='dictfmt dictzip'; export NOSUBDIR; \
	${MAKE} configure > /dev/null; \
	${MAKE} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	unset NOSUBDIR; \
	\
	echo =========== all with MKPIE=yes ============; \
	${MAKE} cleandir > /dev/null; \
	${MAKE} configure MKPIE=yes > /dev/null; \
	${MAKE} -j4 all MKPIE=yes > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== all with STATICLIBS=everything... ============; \
	${MAKE} cleandir > /dev/null; \
	env STATICLIBS='libmaa libdz' ${MAKE} configure > /dev/null; \
	env STATICLIBS='libmaa libdz' ${MAKE} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== print_deps ============; \
	${MAKE} print_deps | grep -E '^(all|test)'; \
	echo =====; \
	NOSUBDIR='dictfmt dictzip' \
	   ${MAKE} print_deps | grep -E '^(all|test)'; \
	echo =====; \
	NODEPS='test2-*:test2-dict*' TARGETS=test2 \
	   ${MAKE} print_deps | grep -E '^(all|test)'; \
	\
	true =========== cleandir ============; \
	unset NOSUBDIR || true; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
