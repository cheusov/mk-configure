# Copyright (c) 2009-2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_MKC_IMP_LINKS_MK)
_MKC_IMP_LINKS_MK := 1

.PHONY:		linksinstall
linksinstall:

do_install2:	linksinstall

.if ${MKINSTALL:tl} == "yes"

linksinstall:
.for l r in ${LINKS}
	${RM} -f ${DESTDIR}${r}; ${LN} ${DESTDIR}${l} ${DESTDIR}${r}
.endfor
.for l r in ${SYMLINKS}
	${RM} -f ${DESTDIR}${r}; ${LN_S} ${l} ${DESTDIR}${r}
.endfor

.for l r in ${LINKS}
UNINSTALLFILES +=	${DESTDIR}${r}
INSTALLDIRS    +=	${DESTDIR}${r:H}
.endfor

.for l r in ${SYMLINKS}
UNINSTALLFILES +=	${DESTDIR}${r}
INSTALLDIRS    +=	${DESTDIR}${r:H}
.endfor

.endif # MKINSTALL=yes
.endif # _MKC_IMP_LINKS_MK
