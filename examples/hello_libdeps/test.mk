.PHONY : test_output
test_output:
	@set -e; LC_ALL=C; export LC_ALL; \
	LD_LIBRARY_PATH=${OBJDIR_libs_libfoo}:${OBJDIR_libs_libfooqux}:${OBJDIR_libs_libbar}:${OBJDIR_libs_libbaz}; \
	DYLD_LIBRARY_PATH=$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH; \
	echo =========== fooquxfoobar ============; \
	${OBJDIR_progs_fooquxfoobar}/fooquxfoobar; \
	echo =========== foobaz ============; \
	${OBJDIR_progs_foobaz}/foobaz; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== depends ============; \
	${MAKE} ${MAKEFLAGS} -j4 depend > /dev/null; \
	mkc_long_lines `find ${.CURDIR} -type f -name .depend` | \
	awk '{for (i=1; i <= NF; ++i) if ($$i ~ /\/usr\//) $$i = ""; print $$0; }' | \
	awk '{$$1 = $$1; gsub(/[.]o[ps]/, ".o"); print $$0}' | sort | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}${PREFIX} ${.OBJDIR}/usr ${.OBJDIR}/Users ${.OBJDIR}/home; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
