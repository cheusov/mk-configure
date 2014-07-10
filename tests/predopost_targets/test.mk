.PHONY : test_output
test_output :
	@set -e; \
	\
	{ \
	echo '=========== {pre,do,post}_all ============'; \
	for t in clean cleandir install all uninstall installdirs depend; \
	do \
		${MAKE} ${MAKEFLAGS} -j1 $$t | \
		grep -v checking; \
	done ; \
	env MKINSTALLDIRS=no ${MAKE} ${MAKEFLAGS} -j1 install; \
	} | env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	true =========== cleandir ============; \
	env REAL_TARGETS=1 ${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
