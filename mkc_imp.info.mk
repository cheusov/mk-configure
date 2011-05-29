# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_INFO_MK) && defined(TEXINFO)
_MKC_IMP_INFO_MK := 1

.include <mkc_imp.init.mk>

MAKEINFO     ?=	makeinfo
INFOFLAGS    ?=	
INSTALL_INFO ?=	install-info

.PHONY:		infoinstall

.SUFFIXES: .txi .texi .texinfo .info

.txi.info .texi.info .texinfo.info:
	${MAKEINFO} ${INFOFLAGS} --no-split -o $@ $<

.if defined(TEXINFO) && !empty(TEXINFO)
realall: ${TEXINFO}
INFOFILES =	${TEXINFO:S/.texinfo/.info/g:S/.texi/.info/g:S/.txi/.info/g}
.NOPATH:	${INFOFILES}

.if ${MKINFO:tl} != "no"
realall: ${INFOFILES}

.if ${MKINSTALL:tl} == "yes"
realinstall: infoinstall

CLEANFILES +=	${INFOFILES}

destination_infos = ${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}@}

infoinstall:: ${destination_infos}
.PRECIOUS: ${destination_infos}
.PHONY: ${destination_infos}

__infoinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} ${INSTPRIV} \
	    -o ${INFOOWN_${.ALLSRC:T}:U${INFOOWN}} \
	    -g ${INFOGRP_${.ALLSRC:T}:U${INFOGRP}} \
	    -m ${INFOMODE_${.ALLSRC:T}:U${INFOMODE}} \
	    ${.ALLSRC} ${.TARGET}
	@${INSTALL_INFO} --remove --info-dir=${DESTDIR}${INFODIR} ${.TARGET}
	${INSTALL_INFO} --info-dir=${DESTDIR}${INFODIR} ${.TARGET}

.for F in ${INFOFILES:O:u}
${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}: ${F} __infoinstall
.endfor

UNINSTALLFILES  +=	${destination_infos}
INSTALLDIRS     +=	${destination_infos:H}
.endif # MKINSTALL
.endif # MKINFO

.endif # TEXINFO

.endif # _MKC_IMP_INFO_MK
