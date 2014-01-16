CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out

.PHONY : test_output
test_output:
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	MKC_CACHEDIR=${.CURDIR}/.cache; export MKC_CACHEDIR; \
	rm -rf $$tmp_out $$MKC_CACHEDIR; \
	${MAKE} ${MAKEFLAGS} errorcheck 2>&1 | \
	grep 'checking.*header' ;\
	if test -f $$MKC_CACHEDIR/_mkc_header_string_h.c; then \
	   echo cache file exists; \
	else \
	   echo cache file does not exist; \
	fi \
	; \
	${MAKE} ${MAKEFLAGS} cleandir 2>/dev/null 1>&2

#	rm -rf $$MKC_CACHEDIR; \

.include <mkc.minitest.mk>
