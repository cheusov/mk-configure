# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_POD_MK)
_MKC_IMP_POD_MK=1

POD2MAN?=		pod2man
POD2MAN_FLAGS:=		-r '' -n '${.TARGET:T:R}' -c '' ${POD2MAN_FLAGS}

MESSAGE.pod2man ?=	@${_MESSAGE} "POD2MAN: ${.TARGET}"
COMPILE.pod2man ?=	${_V} ${POD2MAN} ${POD2MAN_FLAGS}

.SUFFIXES: .pod

.for i in 1 2 3 4 5 6 7 8 9
.SUFFIXES: .${i}
.pod.${i}:
	${MESSAGE.pod2man}
	${COMPILE.pod2man} -s ${i} ${.ALLSRC} > ${.TARGET}
.endfor

.endif # _MKC_IMP_POD_MK
