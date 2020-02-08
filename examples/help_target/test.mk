.PHONY : test_output
test_output:
	@set -e; \
	echo ============ VALUE = 7 =============; \
	${.OBJDIR}/print_value; \
	\
	echo =========== VALUE = 711 ============; \
	env VALUE=711 ${MAKE} ${MAKEFLAGS} clean all > /dev/null; \
	${.OBJDIR}/print_value; \
	\
	echo ======= help ==========; \
	${MAKE} ${MAKEFLAGS} help; \
	\
	echo ===== help_subprj =====; \
	${MAKE} ${MAKEFLAGS} help_subprj; \
	\
	echo ===== help_use =====; \
	${MAKE} ${MAKEFLAGS} help_use; \
	\
	echo =======================; \
	${MAKE} ${MAKEFLAGS} cleandir 2>/dev/null 1>&2

.include <mkc.minitest.mk>
