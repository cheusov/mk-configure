EXCL_RE='autom4te[.]cache'

.PHONY : test_output
test_output:
	@ \
	${.OBJDIR}/proj/hello_autotools; \
	rm -rf ${.OBJDIR}/proj${PREFIX}; \
	\
	echo =========== all ============; \
	find ${.OBJDIR}/proj -type f | grep -Ev '${EXCL_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}/proj"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 \
		DESTDIR=${.OBJDIR}/proj > /dev/null; \
	find ${.OBJDIR}/proj${PREFIX} -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}/proj"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall \
		DESTDIR=${.OBJDIR}/proj > /dev/null; \
	find ${.OBJDIR}/proj${PREFIX} -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}/proj"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}/proj"; \
	\
	echo ========== all SHRTOUT=yes ===========; \
	${MAKE} ${MAKEFLAGS} all SHRTOUT=yes | grep -v 'loading site script' | \
	grep -E '^[[:alpha:]]+:'; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR}/proj -type f | grep -vE '${EXCL_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}/proj"

.include <mkc.minitest.mk>
