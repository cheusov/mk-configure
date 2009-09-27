#	$NetBSD: bsd.inc.mk,v 1.1.1.1 2006/07/14 23:13:00 jlam Exp $

.PHONY:		incinstall
realinstall:	incinstall

.if defined(INCS)

destination_incs=${INCS:@I@${DESTDIR}${INCSDIR}/$I@}

incinstall:: ${destination_incs}
.PRECIOUS: ${destination_incs}
.PHONY: ${destination_incs}

__incinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${BINOWN} \
	    -g ${BINGRP} -m ${NONBINMODE} ${.ALLSRC} ${.TARGET}

.for I in ${INCS:O:u}
${DESTDIR}${INCSDIR}/$I: $I __incinstall
.endfor

UNINSTALLFILES+=	${destination_incs}
INSTALLDIRS+=		${destination_incs:H}

.endif # INCS

.if !target(incinstall)
incinstall::
.endif
