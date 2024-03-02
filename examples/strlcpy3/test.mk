FUNCS_RE=(strlcat|strlcpy|getline|progname)[.][do]

.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/input.in | \
	mkc_test_helper_paths; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== depend ==========; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR} -type f | \
	grep '[.]d$$' | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} ${MAKEFLAGS} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	grep -vE '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} ${MAKEFLAGS} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== clean ===========; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -vE '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= CLEANFILES ==========; \
	echo '${CLEANFILES}' | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o.?$$/) print $$i}'; \
	echo ======= depend to OBJDIR ==========; \
	mkdir obj; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR}/obj -type f | grep -vE '${FUNCS_RE}' | \
	grep -v _mkc | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf obj; \
	true _______ cleandir _______ %%; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
