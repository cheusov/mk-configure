# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_POD_MK)
_MKC_IMP_POD_MK=1

POD2MAN?=	pod2man
POD2MAN_FLAGS?=

.SUFFIXES: .pod

.for i in 1 2 3 4 5 6 7 8 9
.SUFFIXES: .${i}
.pod.${i}:
	${POD2MAN} -s ${i} -r '' -n '${.TARGET:T:R}' -c '' ${POD2MAN_FLAGS} \
	    ${.ALLSRC} > ${.TARGET}
.endfor

.endif # _MKC_IMP_POD_MK
