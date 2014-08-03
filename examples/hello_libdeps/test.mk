.PHONY : test_output
test_output:
	@set -e; LC_ALL=C; export LC_ALL; \
	LD_LIBRARY_PATH=${OBJDIR_libs_libfoo}:${OBJDIR_libs_libfooqux}:${OBJDIR_libs_libbar}; \
	DYLD_LIBRARY_PATH=$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	${OBJDIR_progs_fooquxfoobar}/fooquxfoobar; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
