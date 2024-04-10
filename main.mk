# Copyright (c) 2014-2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
##################################################
.include "help.mk"
.include "use.mk"

##################################################
SUBPRJ_DFLT =   builtins examples/helpers mk scripts features doc
SUBPRJ      =	scripts:examples scripts:presentation ${SUBPRJ_DFLT} \
		scripts:builtins scripts:examples/helpers scripts:mk scripts:features scripts:doc

.include "tests.mk"

.for t in ${tests}
SUBPRJ +=	tests/${t}:tests
.endfor

.include "examples.mk"
.for t in ${examples}
SUBPRJ +=	examples/${t}:examples
.endfor

NODEPS +=	install-examples/helpers:install
NODEPS +=	test-examples/multilibs:test test-examples/multilibs:test-examples

##################################################
# The following is necessary for target "test-examples"
NOEXPORT_VARNAMES =	MKC_CACHEDIR SRCTOP OBJDIR

#
PATH        :=		${.CURDIR}/examples/helpers:${.CURDIR}/scripts:${PATH}
.export INSTALL PATH

##################################################
.PHONY: pdf
pdf: all-presentation
pdf:
	@set -e; cd presentation; \
	${MAKE} ${MAKEFLAGS} clean-garbage; \
	rm -f myprojects.* _mkc_*

##################################################
cleandir:	cleandir-tests cleandir-presentation cleandir-examples
clean:		clean-tests clean-presentation clean-examples

test:		test-tests test-examples

##################################################
.include "Makefile.inc"
.include <mkc.mk>
