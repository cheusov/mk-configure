# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
_macro = SLIST SIMPLEQ STAILQ LIST TAILQ TAILQ

.for m in ${_macro}
MKC_CHECK_DEFINES +=	${m}_ENTRY:sys/queue.h
_macro.${m}        =	1
.endfor

MKC_NOAUTO=1

.include <mkc.configure.mk>

.for f in ${MKC_FEATURES}
.if defined(_macro.${f}) && !${HAVE_DEFINE.${m}_ENTRY.sys/queue.h:U0}
bad=1
.endif
.endfor

.ifndef bad
CFLAGS+=	-DMKC_SYS_QUEUE_IS_FINE=1
.endif

.undef bad

.for m in ${_macro}
.undef _macro.${m}
.endfor
