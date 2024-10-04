# I added "codingstylechk" to "test" just for mk-configure regr. test

test:
.PHONY : test_output
test_output :
	@:; \
	${OBJDIR_hello1}/hello1; \
	${OBJDIR_hello2}/hello2; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= codingstylechk ==========; \
	${MAKE} cleandir 2>/dev/null 1>&2; \
	{ ${MAKE} codingstylechk 2>&1; echo cschk ex=$$?; } | \
	env NOSORT=1 mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ============= files ===============; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== manpages ============; \
	env MKCATPAGES=no ${MAKE} cleandir 2>/dev/null 1>&2; \
	${MAKE} manpages 2>/dev/null 1>&2; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}
	\
	${MAKE} cleandir 2>/dev/null 1>&2

.include <mkc.minitest.mk>
