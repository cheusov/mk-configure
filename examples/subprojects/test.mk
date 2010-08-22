.PHONY : test_output
test_output :
	@set -e; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	LD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	MKINSTALLDIRS=no; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${.CURDIR}/hello/hello_subprojects; \
	${.CURDIR}/hello/hello_subprojects2; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
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
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= libhello1 ==========; \
	${MAKE} ${MAKEFLAGS} libhello1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= all-libhello2 ==========; \
	${MAKE} ${MAKEFLAGS} all-libhello2 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= cleandir-libhello1 ==========; \
	${MAKE} ${MAKEFLAGS} cleandir-libhello1 DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	\
	echo ======= library dependencies =======; \
	PREFIX=${.CURDIR}/usr; export PREFIX; \
	${MAKE} ${MAKEFLAGS} all installdirs install >&2; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	LD_LIBRARY_PATH=${.CURDIR}/usr/lib; \
	DYLD_LIBRARY_PATH=${.CURDIR}/usr/lib; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${.CURDIR}/usr/bin/hello_subprojects; \
	rm -rf ${.CURDIR}/usr

CLEANDIRS+=	${.CURDIR}/usr
.include <mkc.minitest.mk>
