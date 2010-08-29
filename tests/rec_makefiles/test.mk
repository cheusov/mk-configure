.PHONY : test
test:
	set -e; env VERBOSE_ECHO=: ${MAKE} all >${.OBJDIR}/_output.tmp; \
	if diff ${.CURDIR}/expect.out ${.OBJDIR}/_output.tmp; \
	then echo '      succeeded' 1>&2; \
	else echo '      FAILED' 1>&2; false; \
	fi

CLEANFILES+=	${.OBJDIR}/_output.tmp
