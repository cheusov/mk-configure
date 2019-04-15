CLEANDIRS +=	${.OBJDIR}/home
install_dirs =	${.OBJDIR}/usr ${.OBJDIR}/opt ${.OBJDIR}/home

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${install_dirs}; \
	echo PROJECTNAME=${PROJECTNAME}; \
	LUA_PATH=${.CURDIR}/?.lua; \
	LUA_CPATH=${.OBJDIR}/?.so; \
	export LUA_PATH LUA_CPATH; \
	./foobar; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL|_mkc_prog_lua' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} PREFIX=/usr/local \
		> /dev/null; \
	find ${install_dirs} -type f | \
	mkc_test_helper /usr/local "${.OBJDIR}" | uniq; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} PREFIX=/usr/local > /dev/null; \
	find ${.OBJDIR}/usr -type f | \
	mkc_test_helper /usr/local "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL|_mkc_prog_lua' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install2 ==========; \
	env PREFIX=/home/cheusov/local \
	    LUA_LMODDIR=/home/cheusov/local/share/lua/5.1 \
	    LUA_CMODDIR=/home/cheusov/local/lib/lua/5.1 \
	    ${MAKE} ${MAKEFLAGS} all install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type d | grep -Ev '_mkc_prog_lua' | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | uniq; \
	rm -rf ${.OBJDIR}/home; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
