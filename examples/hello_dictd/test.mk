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
