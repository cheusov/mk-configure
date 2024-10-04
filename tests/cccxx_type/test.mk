.PHONY : test_output
test_output :
	@set -e; \
	echo =========== test1 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test1.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test2 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test2.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test3 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test3.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test4 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test4.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test5 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test5.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test6 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test6.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test7 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test7.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test8 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test8.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test9 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test9.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test10 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test10.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test11 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test11.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test12 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test12.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test13 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test13.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test14 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test14.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test15 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test15.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test16 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test16.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test17 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test17.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test18 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test18.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test19 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test19.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test20 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test20.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test21 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test21.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test22 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test22.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test23 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test23.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test24 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test24.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test25 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test25.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test26 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test26.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test27 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test27.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test28 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test28.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test29 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test29.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test30 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test30.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	echo =========== test31 ============; \
	env MKC_NOCACHE=1 ${MAKE} -f test31.mk all 2>&1 | \
		head -1 | mkc_test_helper2; \
	\
	${MAKE} cleandir 2>/dev/null >&2
