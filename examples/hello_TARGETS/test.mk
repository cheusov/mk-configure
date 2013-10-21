# I added "codingstylechk" to "test" just for mk-configure regr. test

test:
.PHONY : test_output
test_output :
	@:; \
	${OBJDIR_hello1}/hello1; \
	${OBJDIR_hello2}/hello2; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= codingstylechk ==========; \
	${MAKE} ${MAKEFLAGS} cleandir 2>/dev/null 1>&2; \
	{ ${MAKE} ${MAKEFLAGS} codingstylechk 2>&1; echo cschk ex=$$?; } | \
	env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ============= files ===============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
