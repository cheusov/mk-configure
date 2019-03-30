# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP_F_SYSQUEUE_MK
_MKC_IMP_F_SYSQUEUE_MK := 1

.include <mkc.conf.mk>

_macro = SLIST SIMPLEQ STAILQ LIST TAILQ TAILQ

.for m in ${_macro}
MKC_CHECK_DEFINES +=	${m}_ENTRY:sys/queue.h
_macro.${m}        =	1
.endfor

.include <mkc.conf.mk>

.for f in ${MKC_FEATURES}
.if defined(_macro.${f}) && !${HAVE_DEFINE.${m}_ENTRY.sys/queue.h:U0}
bad=1
.endif
.endfor

.ifndef bad
CFLAGS+=	-DMKC_SYS_QUEUE_IS_FINE=1
.endif

.for m in ${_macro}
.undef _macro.${m}
.endfor

.undef bad
.undef _macro

CPPFLAGS +=	-D_MKC_CHECK_SLIST

.endif # _MKC_IMP_F_SYSQUEUE_MK
