.PHONY : test_output
test_output:
	@set -e; \
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -v '[.]tmp$$' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -v '[.]tmp$$' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
