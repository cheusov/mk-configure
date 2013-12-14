# Copyright (c) 2009-2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

TEST_PREREQS ?= all

.PHONY : test
test: ${TEST_PREREQS}
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	tmp_out=${.OBJDIR}/${.CURDIR:T}.test.out; \
	${RM} -f $$tmp_out; \
	${MAKE} ${MAKEFLAGS} test_output > $$tmp_out.tmp; \
	mv $$tmp_out.tmp $$tmp_out; \
	if test -f ${.CURDIR}/expect.${OPSYS}.out; then \
		expect=${.CURDIR}/expect.${OPSYS}.out; \
	else \
		expect=${.CURDIR}/expect.out; \
	fi; \
	diff $$expect $$tmp_out && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }

CLEANFILES   +=		${.OBJDIR}/${.CURDIR:T}.test.out
#DISTCLEANFILES+=	${.OBJDIR}/${.CURDIR:T}.test.out.tmp
