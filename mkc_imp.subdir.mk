# Copyright (c) 2009-2012 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_SUBDIR_MK)
_MKC_IMP_SUBDIR_MK := 1

.for dir in ${SUBDIR}
.if empty(NOSUBDIR:U:M${dir})
__REALSUBPRJ += ${dir}
.endif
.endfor

# for obscure reasons, we can't do a simple .if ${dir} == ".WAIT"
# but have to assign to __TARGDIR first.
.for targ in ${TARGETS}
.for dir in ${__REALSUBPRJ}
__TARGDIR := ${dir}
.if ${__TARGDIR} == ".WAIT"
SUBDIR_${targ} += .WAIT
.else
.PHONY: ${targ}-${dir}
${targ}-${dir}: .MAKE __recurse
SUBDIR_${targ} += ${targ}-${dir}
.endif # .WAIT
.endfor # dir

.if !commands(${targ})
${targ}: ${SUBDIR_${targ}:U}
.endif

.endfor # targ

.for dir in ${__REALSUBPRJ}
.PHONY: ${dir}
${dir}: all-${dir}
.endfor # dir

# Make sure all of the standard targets are defined, even if they do nothing.
${TARGETS}:

.include <mkc_imp.objdir.mk>

.endif # _MKC_IMP_SUBDIR_MK
