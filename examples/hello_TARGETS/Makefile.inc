CSCHK = test hello1 = '${.CURDIR:T}' # something useful should be here

.if make(codingstylechk)
MKCHECKS = no
.endif

.PHONY: codingstylechk
codingstylechk:
	@${_MESSAGE_V} "Coding style check for ${PROJECTNAME}"; \
	${CSCHK} || { echo FAILED 1>&2; false; }
