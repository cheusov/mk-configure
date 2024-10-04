# Copyright (c) 2009-2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

TEST_PREREQS ?= all
MKC_DIFF     ?=	diff

_tmp_out:=${.OBJDIR}/${.CURDIR:T}.test.out

.PHONY : test
test: ${TEST_PREREQS}
	@echo 'Testing ${.CURDIR}... ' 1>&2; \
	set -e; cd ${.CURDIR}; \
	${RM} -f ${_tmp_out}; \
	${MAKE} test_output > ${_tmp_out}.tmp; \
	mv ${_tmp_out}.tmp ${_tmp_out}; \
	if test -f ${.CURDIR}/expect.${OPSYS}.out; then \
		expect=${.CURDIR}/expect.${OPSYS}.out; \
	else \
		expect=${.CURDIR}/expect.out; \
	fi; \
	${MKC_DIFF} $$expect ${_tmp_out} && \
	echo '      succeeded' 1>&2 || \
	{ echo '      FAILED' 1>&2; false; }

CLEANFILES   +=		${_tmp_out}
#CLEANDIRFILES+=	${.OBJDIR}/${.CURDIR:T}.test.out.tmp
