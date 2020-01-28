.PHONY : test_output
test_output :
	@set -e; \
	\
	{ \
	echo '=========== {pre,do,post}_recursive ============'; \
	for t in errorcheck clean cleandir install all uninstall installdirs depend; do \
		${MAKE} ${MAKEFLAGS} -j1 $$t | \
		grep -v checking; \
	done ; \
	env MKINSTALLDIRS=no ${MAKE} ${MAKEFLAGS} -j1 install; \
	} | env NOSORT=1 mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo '=========== {pre,do,post}_nonrec ============'; \
	for t in bin_tar bin_targz bin_tarbz2 bin_zip bin_deb; do \
		env INCFILE=Makefile.inc ${MAKE} ${MAKEFLAGS} -j1 $$t | \
		grep -v checking; \
	done ; \
	\
	true =========== cleandir ============; \
	env REAL_TARGETS=1 ${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
