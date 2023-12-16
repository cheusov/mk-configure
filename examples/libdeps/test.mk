run_nm := env NM=${NM:Q} OPSYS=${OPSYS:Q} mkc_test_nm

COMPILER_SUPPORTS_MD ?= yes

.PHONY : test_output
test_output:
	@set -e; LC_ALL=C; export LC_ALL; \
	LD_LIBRARY_PATH=${OBJDIR_libs_libfoo}:${OBJDIR_libs_libfooqux}:${OBJDIR_libs_libbar}:${OBJDIR_libs_libbaz}; \
	DYLD_LIBRARY_PATH=$$LD_LIBRARY_PATH; \
	LIBRARY_PATH=$$LIBRARY_PATH:$$LD_LIBRARY_PATH; \
	export LD_LIBRARY_PATH DYLD_LIBRARY_PATH LIBRARY_PATH; \
	echo =========== fooquxfoobar ============; \
	${OBJDIR_progs_fooquxfoobar}/fooquxfoobar; \
	echo =========== foobaz ============; \
	${OBJDIR_progs_foobaz}/foobaz; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	\
	echo =========== depends ============; \
	${MAKE} ${MAKEFLAGS} -j4 depend > /dev/null; \
	mkc_long_lines `find ${.CURDIR} -type f -name '.depend_*'` | \
	awk '!/^#/ {for (i=1; i <= NF; ++i) if ($$i ~ /^\// && $$i !~ /mk-configure/) $$i = ""; print $$0; }' | \
	awk '{$$1 = $$1; gsub(/[.]o[ps]/, ".o"); print $$0}' | sort | \
	awk ' \
	    / foo[.]o.*:.*[^a-z]foo[.]h/ { foo_foo_ok = 1; } \
	    / bar[.]o.*:.*[^a-z]bar[.]h/ { bar_bar_ok = 1; } \
	    / baz[.]o.*:.*[^a-z]baz[.]h/ { baz_baz_ok = 1; } \
	    / foobaz[.]o.*:.*[^a-z]baz[.]h/ { foobaz_baz_ok = 1; } \
	    / foobaz[.]o.*:.*[^a-z]foo[.]h/ { foobaz_foo_ok = 1; } \
	    / fooqux[.]o.*:.*[^a-z]foo[.]h/ { fooqux_foo_ok = 1; } \
	    / fooqux[.]o.*:.*[^a-z]fooqux[.]h/ { fooqux_fooqux_ok = 1; } \
	    / fooquxfoobar[.]o.*:.*[^a-z]foo[.]h/ { fooquxfoobar_foo_ok = 1; } \
	    / fooquxfoobar[.]o.*:.*[^a-z]bar[.]h/ { fooquxfoobar_bar_ok = 1; } \
	    / fooquxfoobar[.]o.*:.*[^a-z]fooqux[.]h/ { fooquxfoobar_fooqux_ok = 1; } \
	    END { \
		print "foo_foo_ok=" foo_foo_ok;                          \
		print "baz_baz_ok=" baz_baz_ok;                          \
		print "foobaz_baz_ok=" foobaz_baz_ok;                    \
		print "foobaz_foo_ok=" foobaz_foo_ok;                    \
		print "fooqux_foo_ok=" fooqux_foo_ok;                    \
		print "fooqux_fooqux_ok=" fooqux_fooqux_ok;              \
		print "fooquxfoobar_foo_ok=" fooquxfoobar_foo_ok;        \
		print "fooquxfoobar_fooqux_ok=" fooquxfoobar_fooqux_ok;  \
	    }' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	rm -rf ${.OBJDIR}/`echo ${PREFIX} | cut -d/ -f2`; \
	\
	echo =========== all with STATICLIBS=... ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	env STATICLIBS='libfoo libbar' ${MAKE} ${MAKEFLAGS} configure > /dev/null; \
	env STATICLIBS='libfoo libbar' ${MAKE} ${MAKEFLAGS} -j4 all > /dev/null; \
	find ${.OBJDIR} -type f -o -type l | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install with STATICLIBS=... ==========; \
	env STATICLIBS='libfoo libbar' ${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type l -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	case ${OPSYS} in \
	*BSD|DragonFly|SunOS|Linux) \
	    ${run_nm} ${OBJDIR_libfooqux}/libfooqux.so;; \
	*) \
	    printf 'symbol foo\nsymbol fooqux\n';; \
	esac; \
	rm -rf ${.OBJDIR}/`echo ${PREFIX} | cut -d/ -f2`; \
	\
	echo ======= all with MKDEPEND=yes ==========; \
	if test ${COMPILER_SUPPORTS_MD:tl} == yes; then \
	    ${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	    MKDEPEND=yes; export MKDEPEND; \
	    ${MAKE} ${MAKEFLAGS} all > /dev/null; \
	    find ${.OBJDIR} -type f -name '*.o' -o -name '*.d' | \
	    mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	    \
	    echo ======= rebuild using dependencies MKDEPEND=yes ==========; \
	    sleep 1; touch ${SRCDIR_libs_libfoo}/foo.h; sleep 1; \
	    ${MAKE} ${MAKEFLAGS} all 2>/tmp/1.out 1>&2; \
	    if test ${OBJDIR_libs_libfooqux}/libfooqux.a -nt ${SRCDIR_libs_libfoo}/foo.h; then echo TRUE2; else echo FALSE2; fi; \
	    if test ${OBJDIR_progs_foobaz}/foobaz -nt ${SRCDIR_libs_libfoo}/foo.h; then echo TRUE3; else echo FALSE3; fi; \
	    if test ${OBJDIR_progs_fooquxfoobar}/fooquxfoobar -nt ${SRCDIR_libs_libfoo}/foo.h; then echo TRUE4; else echo FALSE4; fi; \
	else \
	    echo /objdir/libs/libbar/bar.d; \
	    echo /objdir/libs/libbar/bar.o; \
	    echo /objdir/libs/libbaz/baz.d; \
	    echo /objdir/libs/libbaz/baz.o; \
	    echo /objdir/libs/libfoo/foo.d; \
	    echo /objdir/libs/libfoo/foo.o; \
	    echo /objdir/libs/libfooqux/fooqux.d; \
	    echo /objdir/libs/libfooqux/fooqux.o; \
	    echo /objdir/progs/foobaz/foobaz.d; \
	    echo /objdir/progs/foobaz/foobaz.o; \
	    echo /objdir/progs/fooquxfoobar/fooquxfoobar.d; \
	    echo /objdir/progs/fooquxfoobar/fooquxfoobar.o; \
	    echo ======= rebuild using dependencies MKDEPEND=yes ==========; \
	    echo TRUE2; \
	    echo TRUE3; \
	    echo TRUE4; \
	    :; \
	fi; \
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
