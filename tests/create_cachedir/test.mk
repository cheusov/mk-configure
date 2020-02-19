TEST_MKC_CACHEDIR  =	${.CURDIR}/.cache
CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out ${TEST_MKC_CACHEDIR}
CLEANDIRS    +=		${TEST_MKC_CACHEDIR}

.PHONY : test_output
test_output:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	rm -rf $$tmp_out ${TEST_MKC_CACHEDIR}; \
	${MAKE} ${MAKEFLAGS} errorcheck MKC_CACHEDIR=${TEST_MKC_CACHEDIR} 2>&1 | \
	mkc_test_helper3 ;\
	if test -f ${TEST_MKC_CACHEDIR}/_mkc_header_string_h.c; then \
	   echo cache file exists; \
	else \
	   echo cache file does not exist; \
	fi \
	; \
	${MAKE} ${MAKEFLAGS} cleandir 2>/dev/null 1>&2

#	rm -rf $$MKC_CACHEDIR; \

.include <mkc.minitest.mk>
