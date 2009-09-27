#	$NetBSD: bsd.files.mk,v 1.1.1.1 2006/07/14 23:13:00 jlam Exp $

.if !defined(_BSD_FILES_MK)
_BSD_FILES_MK:=	1

.include <mkc_bsd.init.mk>

.PHONY:		filesinstall
realinstall:	filesinstall

.if defined(FILES) && !empty(FILES)

destination_files= ${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}
filesinstall: ${destination_files}
.PRECIOUS: ${destination_files}
.PHONY: ${destination_files}

__fileinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${FILESOWN_${.ALLSRC:T}:U${FILESOWN}} \
	    -g ${FILESGRP_${.ALLSRC:T}:U${FILESGRP}} \
	    -m ${FILESMODE_${.ALLSRC:T}:U${FILESMODE}} \
	    ${.ALLSRC} ${.TARGET}

.for F in ${FILES:O:u}
${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}: ${F} __fileinstall
.endfor

UNINSTALLFILES+=	${destination_files}
INSTALLDIRS+=		${destination_files:H}

.endif # FILES

.if !target(filesinstall)
filesinstall::
.endif

.endif # _BSD_FILES_MK
