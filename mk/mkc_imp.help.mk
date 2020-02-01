# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP_HELP_MK
_MKC_IMP_HELP_MK   :=   1

.PHYNY: help
help:
.if empty(USE_VARIABLES)
	@echo "${PROJECTNAME} does not provide any special USE_* variables."
	@echo "So, there is nothing to configure in a special way."
.else
	@echo "There are the following variables you may use to configure ${PROJECTNAME}:"
.   for v in ${USE_VARIABLES}
.       if !empty(${v}.descr)
	    @echo "  * ${v} (${${v}.descr})"
.	else
	    @echo "  * ${v}"
.	endif
.       if !empty(${v}.0)
	    @echo "    - ${${v}.0} (the default)"
.       endif
.       for n in 1 2 3 4 5 6 7 8 9 10
.           if !empty(${v}.${n})
		@echo "    - ${${v}.${n}}"
.           endif
.       endfor # n
.   endfor # USE_VARIABLES
.endif # USE_VARIABLES

.endif # _MKC_IMP_HELP_MK
