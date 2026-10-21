.for v in ${vars}
vars_with_vals +=	${v}=${${v}}
.endfor
preset =	${vars_with_vals:S/=1/=2/g:S/=0/=1/g:S/=2/=0/g}

.PHONY : test_output output_vars

output_vars:
.for v in ${vars}
	@echo ${v}=${${v}}
.endfor
.for v in ${CPPFLAGS}
#. if !empty(v:M-DHAVE_*)
	@printf '%s\n' "${v}" | grep HAVE || true
#. endif
.endfor

test_output:
	@${MAKE} output_vars
	@echo ==========
	@env ${preset} ${MAKE} output_vars
