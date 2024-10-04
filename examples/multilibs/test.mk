FUNCS_RE='multilibs.test.out.tmp'

.PHONY : test_output
test_output:
	@set -e; \
	LD_LIBRARY_PATH=${OBJDIR_libsummator}:${OBJDIR_libmultiplier}:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	while read a b; do \
		${OBJDIR_app}/app $$a $$b; \
	done < ${.CURDIR}/input.in; \
	\
	echo '=========== all ============'; \
	find ${.CURDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	${MAKE} -C${.CURDIR} cleandir > /dev/null

.include <mkc.minitest.mk>
