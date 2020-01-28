install_dirs =	${.OBJDIR}/usr ${.OBJDIR}/opt ${.OBJDIR}/home

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${install_dirs}; \
	echo PROJECTNAME=${PROJECTNAME}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${install_dirs} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | uniq; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${install_dirs} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
