FUNCS_RE=(strlcat|strlcpy|getline)[.]o

.PHONY : test_output
test_output:
	@\
	echo ======= ex ==========; \
	${.OBJDIR}/hello err 1 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello err 2 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello err 3 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello errx 1 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello errx 2 2>&1 >/dev/null; echo '$$?='$$?; \
	${.OBJDIR}/hello errx 3 2>&1 >/dev/null; echo '$$?='$$?; \
	echo ======= cleandir ==========; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
