.PHONY : test_output
test_output:
	@${.OBJDIR}/prog -t 123 -n freeargument; \
	${.OBJDIR}/prog -n freeargument -t 123; \
	${.OBJDIR}/prog -t 123 -- -n freeargument

.include <mkc.minitest.mk>
