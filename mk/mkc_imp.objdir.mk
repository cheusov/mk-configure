# Copyright (c) 2012 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.if !defined(_MKC_IMP_OBJDIR_MK)
_MKC_IMP_OBJDIR_MK := 1

.if ${:!if test -d ${.CURDIR}/obj.${MACHINE}; then echo 1; else echo 0; fi!}
  _OBJ_MACHINE_DIR := 1
.elif ${:!if test -d ${.CURDIR}/obj; then echo 1; else echo 0; fi!}
  _OBJ_DIR := 1
.endif

.for i in ${__REALSUBPRJ}
j:=${i:S,/,_,g}
. if empty(j:U:M*[.]*)
EXPORT_VARNAMES += OBJDIR_${i:S,/,_,g}
.   if ${MKRELOBJDIR:tl} == "yes"
OBJDIR_${j} := ${.OBJDIR}/${i}
.   elif defined(MAKEOBJDIRPREFIX)
OBJDIR_${j} := ${MAKEOBJDIRPREFIX}${.CURDIR}/${i}
.   elif defined(MAKEOBJDIR)
OBJDIR_${j} := ${MAKEOBJDIR}
.   elif defined(_OBJ_MACHINE_DIR)
OBJDIR_${j} := ${.CURDIR}/obj.${MACHINE}
.   elif defined(_OBJ_DIR)
OBJDIR_${j} := ${.CURDIR}/obj
.   else
OBJDIR_${j} := ${.CURDIR}/${i}
.   endif # MAKEOBJDIRPREFIX...
.   if ${SHORTPRJNAME:tl} == "yes" && ${i} != ${j}
OBJDIR_${i:T} := ${OBJDIR_${j}}
EXPORT_VARNAMES += OBJDIR_${i:T}
.   endif
. endif # empty(j:U:M*[.]*)

.endfor # i

.undef _OBJ_MACHINE_DIR
.undef _OBJ_DIR

.endif # _MKC_IMP_OBJDIR_MK
