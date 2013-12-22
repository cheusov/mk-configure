check:
	@if test "`${OBJDIR_tools_prog3}/prog3 | tr '\012' ' '`"  = \
	        'This is a message #3 Message #3 '; \
	then \
	   echo ok; \
	else \
	   echo FAILED; false; \
	fi

.include <mkc.mk>
