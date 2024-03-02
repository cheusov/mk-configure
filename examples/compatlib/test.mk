FUNCS_RE=(fgetln|progname|strlcat|strlcpy|getline|err|getdelim|strndup|_mkcfake)[.][do]|custom_attribute

.PHONY : test_output
test_output :
	@set -e; \
	echo =========== all ============; \
	{ find ${.OBJDIR} -type f | \
	  LC_ALL=C sort | \
	  grep -Ev '${FUNCS_RE}|prog1/|prog2/'; \
	  echo ===; \
	  find ${.OBJDIR}/prog1 ${.OBJDIR}/prog2 -type f | \
	  LC_ALL=C sort; \
	} | \
	env NOSORT=1 mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	\
	echo =========== depend ============; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR} -type f | LC_ALL=C sort | \
	grep '[.]d$$' | grep -Ev ${FUNCS_RE:Q} | \
	env NOSORT=1 mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	echo =========== clean ============; \
	${MAKE} ${MAKEFLAGS} clean > /dev/null; \
	find ${.OBJDIR} -type f | grep -v _mkc | grep -Ev ${FUNCS_RE:Q} | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	echo =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null; \
	find ${.OBJDIR} -type f | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	echo ======= depend to OBJDIR ==========; \
	mkdir obj; MAKEOBJDIR=${.OBJDIR}/obj; export MAKEOBJDIR; \
	${MAKE} ${MAKEFLAGS} depend > /dev/null; \
	find ${.OBJDIR}/obj -type f | grep -vE ${FUNCS_RE:Q} | \
	grep -v _mkc | \
	mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	rm -rf obj; unset MAKEOBJDIR; \
	true _______ cleandir _______; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
