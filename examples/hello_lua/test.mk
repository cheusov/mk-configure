DISTCLEANDIRS+=	${.CURDIR}/usr ${.CURDIR}/opt

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}/usr ${.OBJDIR}/opt; \
	echo PROJECTNAME=${PROJECTNAME}; \
	./foobar; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}/usr -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | uniq; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}/usr -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | \
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
	    ${MAKE} ${MAKEFLAGS} all install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | uniq; \
	rm -rf ${.OBJDIR}/home; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
