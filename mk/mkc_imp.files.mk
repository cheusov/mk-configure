# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_BSD_FILES_MK)
_BSD_FILES_MK := 1

.include <mkc.init.mk>

.PHONY:		filesinstall
do_install1:	filesinstall

.if defined(FILES) && !empty(FILES)

.if !commands(do_all)
do_all: ${FILES}
.endif

.if ${MKINSTALL:tl} == "yes"
destination_files = ${FILES:@F@${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}@}

filesinstall: ${destination_files}
.PRECIOUS: ${destination_files}
.PHONY: ${destination_files}

__fileinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${FILESOWN_${.ALLSRC:T}:U${FILESOWN}:Q} \
	    -g ${FILESGRP_${.ALLSRC:T}:U${FILESGRP}:Q} \
	    -m ${FILESMODE_${.ALLSRC:T}:U${FILESMODE}} \
	    ${.ALLSRC} ${.TARGET}

.for F in ${FILES:O:u}
${DESTDIR}${FILESDIR_${F}:U${FILESDIR}}/${FILESNAME_${F}:U${FILESNAME:U${F:T}}}: ${F} __fileinstall
.endfor

UNINSTALLFILES  +=	${destination_files}
INSTALLDIRS     +=	${destination_files:H}
.endif # MKINSTALL
.endif # FILES

.if !target(filesinstall)
filesinstall:
.endif

.endif # _BSD_FILES_MK
