.PHONY : test_output
test_output:
	@set -e; \
	echo ============ VALUE = 7 =============; \
	${.OBJDIR}/print_value; \
	\
	echo =========== VALUE = 711 ============; \
	env VALUE=711 ${MAKE} clean all > /dev/null; \
	${.OBJDIR}/print_value; \
	\
	echo ======= help ==========; \
	${MAKE} help; \
	\
	echo ===== help_subprj =====; \
	${MAKE} help_subprj; \
	\
	echo ===== help_use =====; \
	${MAKE} help_use; \
	\
	echo =======================; \
	${MAKE} cleandir 2>/dev/null 1>&2

.include <mkc.minitest.mk>
