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
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	echo ======= all-dict ==========; \
	${MAKE} ${MAKEFLAGS} all-dict DESTDIR=${.OBJDIR} > /dev/null; \
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
	${MAKE} ${MAKEFLAGS} clean-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= cleandir-dict ==========; \
	${MAKE} ${MAKEFLAGS} cleandir-dict DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

CLEANDIRS+=	${.CURDIR}/usr
.include <mkc.minitest.mk>
