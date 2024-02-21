FUNCS_RE='multilibs.test.out.tmp'

.PHONY : test_output
test_output:
	@set -e; \
	LD_LIBRARY_PATH=${OBJDIR_libsummator}:${OBJDIR_libmultiplier}:$$LD_LIBRARY_PATH; \
	DYLD_LIBRARY_PATH=${LD_LIBRARY_PATH}; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	while read a b; do \
		${OBJDIR_app}/app $$a $$b; \
	done < ${.CURDIR}/input.in; \
	\
	echo ========== depend ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
