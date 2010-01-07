.PHONY : test_output basic auto_rpath
test_output: basic .WAIT auto_rpath

basic:
	@set -e; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	LD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${.CURDIR}/libhello1:${.CURDIR}/libhello2:$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${.CURDIR}/hello/hello_subprojects; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} installdirs install DESTDIR=${.OBJDIR} \
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
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.if ${TARGET_OPSYS} != "NetBSD" && ${TARGET_OPSYS} != "FreeBSD" && ${TARGET_OPSYS} != "DragonFly" && ${TARGET_OPSYS} != "OpenBSD" && ${TARGET_OPSYS} != "MirBSD" && ${TARGET_OPSYS} != "Linux" 
auto_rpath:
	echo == library dependencies ====; \
	PREFIX=${.CURDIR}/usr; export PREFIX; \
	${MAKE} ${MAKEFLAGS} all installdirs install >&2; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	${.CURDIR}/usr/bin/hello_subprojects
.else
auto_rpath:
.endif

CLEANDIRS+=	${.CURDIR}/usr
.include <mkc.minitest.mk>
