.PHONY : test_output
test_output:
	@set -e; cd ${.CURDIR}; \
	\
	echo =========== custom_check1.c ===========; \
	rm -f _mkc_*; \
	mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	MKC_VERBOSE=1; export MKC_VERBOSE; \
	mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	env MKC_NOCACHE=1 mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	env MKC_SHOW_CACHED=1 mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	env MKC_SHOW_CACHED=1 mkc_check_custom -b ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	env mkc_check_custom -b ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	env mkc_check_custom -bl ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	env LDFLAGS='--zzz' mkc_check_custom -bl ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	env LDFLAGS='--zzz' mkc_check_custom -b ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	rm -f _mkc_*; \
	env CFLAGS='--zzz' mkc_check_custom -b ${SRCDIR_configure_test}/custom/custom_check1.c 2>&1; \
	echo =========== custom_check3.c ===========; \
	rm -f _mkc_*; \
	mkc_check_custom ${SRCDIR_configure_test}/custom/custom_check3.c 2>&1; \
	echo =========== my_check2.c ===========; \
	rm -f _mkc_*; \
	mkc_check_custom -b ${SRCDIR_configure_test}/custom/my_check2.c 2>&1; \
	rm -f _mkc_*; \
	mkc_check_custom -lb ${SRCDIR_configure_test}/custom/my_check2.c 2>&1; \
	echo =========== my_check4.c ===========; \
	rm -f _mkc_*; \
	mkc_check_custom ${SRCDIR_configure_test}/custom/my_check4.c 2>&1; \
	rm -f _mkc_*; \
	mkc_check_custom -lb ${SRCDIR_configure_test}/custom/my_check4.c 2>&1; \
	mkc_check_custom -lbd ${SRCDIR_configure_test}/custom/my_check4.c 2>&1; \
	mkc_check_custom -p cache_prefix -n cache_filename -m 'trying to build my_check4 application' -lb ${SRCDIR_configure_test}/custom/my_check4.c 2>&1; \
	ls -1 _mkc_* | sort; \
	echo =======================================

.include <mkc.minitest.mk>
