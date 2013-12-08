# Copyright (c) 2010-2013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_MKC_IMP_SUBPRJ_MK)
_MKC_IMP_SUBPRJ_MK := 1

.for dir in ${SUBPRJ:S/:/ /g}
.if empty(NOSUBDIR:U:M${dir})
__REALSUBPRJ += ${dir}
.endif
.endfor

.ifndef SUBDIR
__REALSUBPRJ := ${__REALSUBPRJ:O:u}
.endif

.if !empty(__REALSUBPRJ:M*-*)
.error "Dash symbol is not allowed inside subdir (${__REALSUBPRJ:M*-*})"
.endif

SUBPRJ_DFLT ?=	${__REALSUBPRJ}

.for targ in ${TARGETS}
.for dir in ${__REALSUBPRJ:N.WAIT}
.PHONY: nodeps-${targ}-${dir}   subdir-${targ}-${dir}   ${targ}-${dir} \
        nodeps-${targ}-${dir:T} subdir-${targ}-${dir:T} ${targ}-${dir:T}
nodeps-${targ}-${dir}: .MAKE __recurse
       ${targ}-${dir}: .MAKE __recurse
subdir-${targ}-${dir}: .MAKE __recurse
.if ${dir} != ${dir:T}
nodeps-${targ}-${dir:T}: nodeps-${targ}-${dir}
       ${targ}-${dir:T}:        ${targ}-${dir}
subdir-${targ}-${dir:T}: subdir-${targ}-${dir}
.endif
.endfor # dir

.if !commands(${targ})
. for dir in ${SUBPRJ_DFLT}
dir_ = ${dir}
.  if ${dir_} == ".WAIT"
_SUBDIR_${targ} += .WAIT
.  else
_SUBDIR_${targ} += ${targ}-${dir}
.  endif # .WAIT
. endfor # dir
${targ}: ${_SUBDIR_${targ}}
.endif #!command(${targ})

.for dep prj in ${SUBPRJ:M*\:*:S/:/ /}
.PHONY: ${targ}-${prj} ${targ}-${dep}
${targ}-${prj}: ${targ}-${dep}
.endfor

.endfor # targ

.for dir in ${__REALSUBPRJ}
.PHONY: ${dir:T} ${dir}
.if ${dir:T} != ${dir}
${dir:T}: all-${dir}
.endif
${dir}: all-${dir}
.endfor # dir

# Make sure all of the standard targets are defined, even if they do nothing.
${TARGETS}:

.include <mkc_imp.objdir.mk>

.endif # _MKC_IMP_SUBPRJ_MK
