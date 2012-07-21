# Copyright (c) 2012 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.

.if !defined(_MKC_IMP_OBJDIR_MK)
_MKC_IMP_OBJDIR_MK := 1


.if ${:!if test -d ${.CURDIR}/obj.${MACHINE}; then echo 1; else echo 0; fi!}
  _OBJ_MACHINE_DIR := 1
.elif ${:!if test -d ${.CURDIR}/obj; then echo 1; else echo 0; fi!}
  _OBJ_DIR := 1
.endif

.for i in ${__REALSUBPRJ}
j:=${i}
.if empty(j:U:M*[./]*)
EXPORT_VARNAMES += OBJDIR_${i}
.  if defined(MAKEOBJDIRPREFIX)
OBJDIR_${i} = ${MAKEOBJDIRPREFIX}${.CURDIR}
.  elif defined(MAKEOBJDIR)
OBJDIR_${i} = ${MAKEOBJDIR}
.  elif defined(_OBJ_MACHINE_DIR)
OBJDIR_${i} = ${.CURDIR}/obj.${MACHINE}
.  elif defined(_OBJ_DIR)
OBJDIR_${i} = ${.CURDIR}/obj
.  else
OBJDIR_${i} = ${.CURDIR}/${i}
.  endif # MAKEOBJDIRPREFIX...
.endif

.endfor # i

.undef _OBJ_MACHINE_DIR
.undef _OBJ_DIR

.endif # _MKC_IMP_OBJDIR_MK
