# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_SCRIPTS_MK)
_MKC_IMP_SCRIPTS_MK:=1

.PHONY:		scriptsinstall
realinstall:	scriptsinstall

realall: ${SCRIPTS}

.if defined(SCRIPTS)
.if !empty(MKINSTALL:M[Yy][Ee][Ss])
destination_scripts=${SCRIPTS:@S@${DESTDIR}${SCRIPTSDIR_${S:S|/|_|g}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S:S|/|_|g}:U${SCRIPTSNAME:U${S:T}}}@}
UNINSTALLFILES+=	${destination_scripts}
INSTALLDIRS+=		${destination_scripts:H}
.endif # MKINSTALL

scriptsinstall:: ${destination_scripts}
.PRECIOUS:       ${destination_scripts}
.PHONY:          ${destination_scripts}

__scriptinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${SCRIPTSOWN_${.ALLSRC:T}:U${SCRIPTSOWN}} \
	    -g ${SCRIPTSGRP_${.ALLSRC:T}:U${SCRIPTSGRP}} \
	    -m ${SCRIPTSMODE_${.ALLSRC:T}:U${SCRIPTSMODE}} \
	    ${.ALLSRC} ${.TARGET}

.for S in ${SCRIPTS:O:u}
${DESTDIR}${SCRIPTSDIR_${S:S|/|_|g}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S:S|/|_|g}:U${SCRIPTSNAME:U${S:T}}}: ${S} __scriptinstall
.endfor

.else # defined(SCRIPTS)
scriptsinstall:
.endif # defined(SCRIPTS)

.endif # _MKC_IMP_SCRIPTS_MK
