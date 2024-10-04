.PHONY : test_output
test_output :
	@set -e; \
	\
	{ \
	   echo '=========== {pre,do,post}_recursive ============'; \
	   for t in errorcheck clean cleandir install all uninstall installdirs depend; do \
		${MAKE} -j1 $$t 2>&1; \
	   done; \
	   env MKINSTALLDIRS=no ${MAKE} -j1 install; \
	} | grep -Ev 'checking|rm -rf ' | \
	env NOSORT=1 mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo '=========== {pre,do,post}_nonrec ============'; \
	for t in bin_tar bin_targz bin_tarbz2 bin_zip bin_deb; do \
		env INCFILE=Makefile.inc ${MAKE} -j1 $$t | \
		grep -Ev 'checking|rm -rf '; \
	done ; \
	\
	true =========== cleandir ============; \
	env REAL_TARGETS=1 ${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
