# Copyright (c) 2010-2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

POD2MAN  ?=		pod2man
POD2MAN_FLAGS   :=	-r '' -n '${.TARGET:T:R}' -c ''
MESSAGE.pod2man ?=	@${_MESSAGE} "POD2MAN: ${.TARGET}"
COMPILE.pod2man ?=	${_V} ${POD2MAN} ${POD2MAN_FLAGS}

POD2HTML ?=		pod2html
POD2HTML_FLAGS   ?=
MESSAGE.pod2html ?=	@${_MESSAGE} "POD2HTML: ${.TARGET}"
COMPILE.pod2html ?=	${_V} ${POD2HTML} ${POD2HTML_FLAGS}

.SUFFIXES: .pod
.for i in 1 2 3 4 5 6 7 8 9
.SUFFIXES: .${i}
.pod.${i}:
	${MESSAGE.pod2man}
	${COMPILE.pod2man} -s ${i} ${.IMPSRC} > ${.TARGET}
.endfor

.SUFFIXES: .html
.pod.html:
	${MESSAGE.pod2html}
	${COMPILE.pod2html} < ${.IMPSRC} > ${.TARGET}

CLEANFILES  +=	pod2htmd.tmp pod2htmi.tmp
