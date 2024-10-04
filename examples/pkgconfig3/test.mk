.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/pkgconfig3; \
	${MAKE} cleandir DESTDIR=${.OBJDIR} > /dev/null

.include <mkc.minitest.mk>
