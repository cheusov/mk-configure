.PHONY : test_output
test_output:
	@set -e; cd ${.CURDIR}; \
	\
	CFLAGS=${CFLAGS:Q}; export CFLAGS; \
	CXXFLAGS=${CXXFLAGS:Q}; export CXXFLAGS; \
	LDFLAGS=${CFLAGS:Q}\ ${LDFLAGS:Q}; export LDFLAGS; \
	echo ============= common tests ============; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom ../custom/custom_check1.c 2>&1 | head -1; \
	echo =========== custom_check1.c ===========; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -t check1 ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	MKC_VERBOSE=1; export MKC_VERBOSE; \
	mkc_check_custom -t check1 ../custom/custom_check1.c 2>&1; \
	mkc_check_custom -t check1 ../custom/custom_check1.c 2>&1; \
	env MKC_NOCACHE=1 mkc_check_custom -t check1 ../custom/custom_check1.c 2>&1; \
	env MKC_SHOW_CACHED=1 mkc_check_custom -t check1 ../custom/custom_check1.c 2>&1; \
	env MKC_SHOW_CACHED=1 mkc_check_custom -t check1 -b ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	env mkc_check_custom -t check1 -b ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	env mkc_check_custom -t check1 -bl ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	env LDFLAGS="$$CFLAGS --zzz" mkc_check_custom -t check1 -bl ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	env LDFLAGS="$$LDLAGS --zzz" mkc_check_custom -t check1 -b ../custom/custom_check1.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	env CFLAGS="$$CFLAGS --zzz" mkc_check_custom -e -t check1 -b ../custom/custom_check1.c 2>&1; \
	echo =========== custom_check3.c ===========; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -t check3 ../custom/custom_check3.c 2>&1; \
	echo =========== my_check2.c ===========; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -t check2 -b ../custom/my_check2.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -t check2 -lb ../custom/my_check2.c 2>&1; \
	echo =========== my_check4.c ===========; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -t check4 ../custom/my_check4.c 2>&1; \
	rm -rf _mkc_*.dSYM; rm -f _mkc_*; \
	mkc_check_custom -lb -t check4 ../custom/my_check4.c 2>&1; \
	mkc_check_custom -lbd -t check4 ../custom/my_check4.c 2>&1; \
	mkc_check_custom -t custom_check4 -m 'trying to build my_check4 application' -lb ../custom/my_check4.c 2>&1; \
	ls -1 _mkc_* | sort; \
	echo =======================================; \
	: =========== cleandir ============; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
