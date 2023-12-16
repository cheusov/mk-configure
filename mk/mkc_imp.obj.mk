# Copyright (c) 2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

obj: # ensure existence

.ifdef MAKEOBJDIRPREFIX
__objdir :=	${MAKEOBJDIRPREFIX}${.CURDIR}
.elif defined(MAKEOBJDIR)
__objdir :=	${MAKEOBJDIR}
.endif # defined(MAKEOBJDIRPREFIX)

.if defined(__objdir)

. if ${MKOBJDIRS:tl} == "yes"
.   if !defined(SUBPRJ)
obj:
	@${MKDIR} -p ${__objdir}
.   endif # !defined(SUBPRJ)
. elif ${MKOBJDIRS:tl} == "auto" && !exists(${__objdir}/)
__objdir_made != if ${MKDIR} -p ${__objdir}; then echo 1; else echo 0; fi

.   if !${__objdir_made}
.     error could not create ${__objdir}
.   endif # ${__objdir_made}

. endif # MKOBJDIRS

.endif # defined(__objdir)...
