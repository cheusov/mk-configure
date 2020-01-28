.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	${.OBJDIR}/prog1; \
	${.OBJDIR}/prog1.sh; \
	${.OBJDIR}/prog1.awk; \
	\
	echo OBJDIR_prog1=${OBJDIR_prog1} | mkc_test_helper_paths; \
	echo OBJDIR_prog2=${OBJDIR_prog2} | mkc_test_helper_paths; \
	\
	echo SRCDIR_prog1=${SRCDIR_prog1} | sed 's,=.*examples/,=,'; \
	echo SRCDIR_prog2=${SRCDIR_prog2} | sed 's,=.*examples/,=,'; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKE_FLAGS} install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKE_FLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKE_FLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}";\
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKE_FLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
