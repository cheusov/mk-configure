FUNCS_RE=(strlcat|strlcpy|getline)[.]o

SUBST_CMD=sed -e 's,Not enough space,Cannot allocate memory,'

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
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
