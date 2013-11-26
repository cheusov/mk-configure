# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.PHONY:		incinstall
realinstall:	incinstall
incinstall:	# ensure existence

.if defined(INCS)
INCSSRCDIR  ?=	.
CPPFLAGS    +=	-I${INCSSRCDIR}

.if ${MKINSTALL:tl} == "yes"
destination_incs =	${INCS:@I@${DESTDIR}${INCSDIR}/$I@}

incinstall: ${destination_incs}
.PRECIOUS: ${destination_incs}
.PHONY: ${destination_incs}

__incinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${BINOWN} \
	    -g ${BINGRP} -m ${NONBINMODE} ${.ALLSRC} ${.TARGET}

.for I in ${INCS:O:u}
${DESTDIR}${INCSDIR}/$I: ${"${INCSSRCDIR}" != ".":?${INCSSRCDIR}/$I:$I} __incinstall
.endfor

UNINSTALLFILES  +=	${destination_incs}
INSTALLDIRS     +=	${destination_incs:H}
.endif # MKINSTALL
.endif # INCS
