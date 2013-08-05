CLEANDIRS +=	${.OBJDIR}/home

.PHONY : test_output
test_output:
	@set -e; \
	rm -rf ${.OBJDIR}/usr; \
	./foobar; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install DESTDIR=${.OBJDIR} PREFIX=/usr/local \
		> /dev/null; \
	find ${.OBJDIR}/usr -type f -o -type d | \
	mkc_test_helper /usr/local "${.OBJDIR}" | uniq; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} uninstall DESTDIR=${.OBJDIR} PREFIX=/usr/local > /dev/null; \
	find ${.OBJDIR}/usr -type f | \
	mkc_test_helper /usr/local "${.OBJDIR}"; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ======= distclean ==========; \
	${MAKE} ${MAKEFLAGS} distclean DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}"; \
	\
	echo ========= install2 ==========; \
	env PREFIX=/home/cheusov/local \
	    LUA_LMODDIR=/home/cheusov/local/share/lua/5.1 \
	    ${MAKE} ${MAKEFLAGS} all install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR} -type f -o -type d | \
	mkc_test_helper "${PREFIX}" "${.OBJDIR}" | uniq; \
	rm -rf ${.OBJDIR}/home; \
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
