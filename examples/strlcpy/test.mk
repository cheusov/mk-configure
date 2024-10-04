FUNCS_RE=(strlcpy|getline)[.][do]

.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello < ${.CURDIR}/input.in; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=yes; export MKCATPAGES; \
	\
	echo ========== depend ==========; \
	${MAKE} cleandir > /dev/null; \
	${MAKE} depend > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== all ============; \
	${MAKE} all > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========= install ==========; \
	${MAKE} install -j3 DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f -o -type d | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======== uninstall =========; \
	${MAKE} -j4 uninstall DESTDIR=${.OBJDIR} > /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ========== clean ===========; \
	${MAKE} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -Ev '${FUNCS_RE}' | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= cleandir ==========; \
	${MAKE} cleandir > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo ======= CLEANFILES ==========; \
	echo "${CLEANFILES}" | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.][do].?$$/) print $$i}'; \
	echo ======= CLEANDIRFILES ==========; \
	echo "${CLEANDIRFILES}" | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.][do].?$$/) print $$i}'; \
	echo ======= depend to OBJDIR ==========; \
	mkdir obj; \
	${MAKE} depend > /dev/null; \
	find ${.OBJDIR}/obj -type f | grep -vE '${FUNCS_RE}' | \
	grep -v _mkc | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf obj; \
	true _______ cleandir _______; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
