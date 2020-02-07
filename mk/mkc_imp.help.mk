# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP_HELP_MK
_MKC_IMP_HELP_MK   :=   1

.if !commands(do_help)
.PHONY: do_help
do_help: _do_help_print_use_variables .WAIT _do_help_print_projects
.endif # !commands(do_help)

_do_help_print_projects: .PHONY
.ifdef SUBPRJ
	@echo "${PROJECTNAME} provides the following subprojects enabled by default"
	@echo "  Enabled by default:"
.   for p in ${SUBPRJ_DFLT:S/:/ /Wg:O:u}
.       if ${p} != "$COMPATLIB"
	@printf "    %-20s: %s\n" ${p} ${HELP_MSG.${p}:U}
.       endif
.   endfor
	@echo "  Others:"
.   for p in ${SUBPRJ:S/:/ /Wg:O:u}
.       if empty(SUBPRJ_DFLT:M${p})
	@printf "    %-20s: %s\n" ${p} ${HELP_MSG.${p}:U}
.       endif
.   endfor
.endif # SUBPRJS

_do_help_print_use_variables: .PHONY
.if empty(USE_VARIABLES)
	@echo "${PROJECTNAME} does not provide any special USE_* variables."
	@echo "So, there is nothing to configure in a special way."
.else
	@echo "There are the following variables you may use to configure ${PROJECTNAME}:"
.   for v in ${USE_VARIABLES}
.       if !empty(${v}.descr)
	    @echo "  * "${v:Q}" ("${${v}.descr}")"
.	else
	    @echo "  * "${v:Q}
.	endif
.       if !empty(${v}.0)
	    @echo "    - "${${v}.0}" (the default)"
.       endif
.       for n in 1 2 3 4 5 6 7 8 9 10
.           if !empty(${v}.${n})
		@echo "    - "${${v}.${n}}
.           endif
.       endfor # n
.   endfor # USE_VARIABLES
.endif # USE_VARIABLES

.endif # _MKC_IMP_HELP_MK
