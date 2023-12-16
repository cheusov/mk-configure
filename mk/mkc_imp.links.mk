# Copyright (c) 2009-2023 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

linksinstall:	.PHONY # ensure existence

realdo_install:	linksinstall

.if ${MKINSTALL:tl} == "yes"

. for l r in ${LINKS}
linksinstall: ${DESTDIR}${r}
${DESTDIR}${r}: ${DESTDIR}${l}
	${RM} -f ${DESTDIR}${r}; ${LN} ${DESTDIR}${l} ${DESTDIR}${r}
. endfor

. for l r in ${SYMLINKS}
linksinstall: ${DESTDIR}${r}
${DESTDIR}${r}:
	${RM} -f ${DESTDIR}${r}; ${LN_S} ${l} ${DESTDIR}${r}
. endfor

.for l r in ${LINKS}
UNINSTALLFILES +=	${DESTDIR}${r}
INSTALLDIRS    +=	${DESTDIR}${r:H}
.endfor

.for l r in ${SYMLINKS}
UNINSTALLFILES +=	${DESTDIR}${r}
INSTALLDIRS    +=	${DESTDIR}${r:H}
.endfor

.endif # MKINSTALL=yes
