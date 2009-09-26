#	$NetBSD: bsd.files.mk,v 1.1.1.1 2006/07/14 23:13:00 jlam Exp $

.if !defined(_BSD_FILES_MK)
_BSD_FILES_MK:=	1

.include <mkc_bsd.init.mk>

.PHONY:		filesinstall
realinstall:	filesinstall

.if defined(FILES) && !empty(FILES)

filesinstall:: ${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}
.PRECIOUS: ${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}
.PHONY: ${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}

__fileinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${FILESOWN_${.ALLSRC:T}:U${FILESOWN}} \
	    -g ${FILESGRP_${.ALLSRC:T}:U${FILESGRP}} \
	    -m ${FILESMODE_${.ALLSRC:T}:U${FILESMODE}} \
	    ${.ALLSRC} ${.TARGET}

.for F in ${FILES:O:u}
${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}: ${F} __fileinstall
.endfor

UNINSTALLFILES+=	${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}
INSTALLDIRS+=		${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}@}

.endif # FILES

.if !target(filesinstall)
filesinstall::
.endif

.endif # _BSD_FILES_MK
