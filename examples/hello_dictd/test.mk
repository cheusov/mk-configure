.PHONY : test_output
test_output :
	@set -e; \
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
	  *BSD|Linux) \
	    ${NM} ${.CURDIR}/libmaa/libmaa*.so | awk '$$2 == "T" {print "libmaa " $$3}'; \
	    ${NM} ${.CURDIR}/libdz/libdz*.so | awk '$$2 == "T" {print "libdz " $$3}';; \
	  SunOS) \
	    ${NM} -P ${.CURDIR}/libmaa/libmaa*.so | awk '$$2 == "T" {print "libmaa " $$1}'; \
	    ${NM} -P ${.CURDIR}/libdz/libdz*.so | awk '$$2 == "T" {print "libdz " $$1}';; \
	  *) \
	    printf 'libmaa fake4\nlibmaa fake5\nlibmaa fake6\nlibdz fake3\n';; \
	esac; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= installdirs ==========; \
	${MAKE} ${MAKEFLAGS} installdirs DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
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
	echo ======= errorcheck ==========; \
	${MAKE} ${MAKEFLAGS} errorcheck > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	echo ======= all-dict ==========; \
	${MAKE} ${MAKEFLAGS} all-dict > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
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
	echo ======= uninstall-dict ==========; \
	${MAKE} ${MAKEFLAGS} uninstall-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean-dict ===========; \
	${MAKE} ${MAKEFLAGS} clean-dict > /dev/null; \
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
	${MAKE} ${MAKEFLAGS} uninstall-doc DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo =========== all with NOSUBDIR ============; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	NOSUBDIR='dictfmt dictzip'; export NOSUBDIR; \
	${MAKE} ${MAKEFLAGS} all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	true =========== cleandir ============; \
	unset NOSUBDIR || true; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
