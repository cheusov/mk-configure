CLEANDIRS +=	${.OBJDIR}/home
install_dirs =	${.OBJDIR}/usr ${.OBJDIR}/opt ${.OBJDIR}/home

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}/usr; \
	LUA_PATH=${.CURDIR}/?.lua; \
	LUA_CPATH=${.OBJDIR}/?.so; \
	export LUA_PATH LUA_CPATH; \
	./foobar; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL|_mkc_prog_lua' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 DESTDIR=${.OBJDIR} PREFIX=/usr/local \
		> /dev/null; \
	find ${install_dirs} -type f | \
	mkc_test_helper /usr/local ${.OBJDIR:Q} ${.CURDIR:Q} | uniq; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall DESTDIR=${.OBJDIR} PREFIX=/usr/local > /dev/null; \
	find ${install_dirs} -type f | \
	mkc_test_helper /usr/local ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== clean ===========; \
	${MAKE} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev 'INSTALL|_mkc_prog_lua' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install2 ==========; \
	env PREFIX=/home/cheusov/local \
	    LUA_LMODDIR=/home/cheusov/local/share/lua/5.1 \
	    ${MAKE} all install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type d | grep -Ev '_mkc_prog_lua' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q} | uniq; \
	rm -rf ${.OBJDIR}/home; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
