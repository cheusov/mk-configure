#	$NetBSD: bsd.inc.mk,v 1.1.1.1 2006/07/14 23:13:00 jlam Exp $

.PHONY:		incinstall
realinstall:	incinstall

.if defined(INCS)

incinstall:: ${INCS:@I@${DESTDIR}${INCSDIR}/$I@}
.PRECIOUS: ${INCS:@I@${DESTDIR}${INCSDIR}/$I@}
.PHONY: ${INCS:@I@${DESTDIR}${INCSDIR}/$I@}

__incinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${BINOWN} \
	    -g ${BINGRP} -m ${NONBINMODE} ${.ALLSRC} ${.TARGET}

.for I in ${INCS:O:u}
${DESTDIR}${INCSDIR}/$I: $I __incinstall
.endfor

.endif # INCS

.if !target(incinstall)
incinstall::
.endif
