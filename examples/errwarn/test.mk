SUBST_CMD=sed -e 's,Not enough space,Cannot allocate memory,' -e 's,Out of memory,Cannot allocate memory,'

.PHONY : test_output
test_output:
	@\
	echo ======= ex ==========; \
	{ ${.OBJDIR}/hello err 1 2>&1 >/dev/null; echo '$$?='$$?; } | ${SUBST_CMD}; \
	{ ${.OBJDIR}/hello err 2 2>&1 >/dev/null; echo '$$?='$$?; } | ${SUBST_CMD}; \
	{ ${.OBJDIR}/hello err 3 2>&1 >/dev/null; echo '$$?='$$?; } | ${SUBST_CMD}; \
	${.OBJDIR}/hello errx 1 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello errx 2 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello errx 3 2>&1 >/dev/null; echo '$$?='$$?; \
	echo ======= CLEANFILES ==========; \
	${MAKE} ${MAKEFLAGS} print_values VARS='CLEANFILES' MKCHECKS=no | \
	awk '{for(i=1; i<=NF; ++i) if ($$i ~ /[.]o.?$$/) print $$i}'; \
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
