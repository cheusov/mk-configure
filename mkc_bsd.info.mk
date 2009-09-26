#	$NetBSD: bsd.info.mk,v 1.1.1.1 2006/07/14 23:13:00 jlam Exp $

.ifndef _MKC_BSD_INFO_MK
_MKC_BSD_INFO_MK=1

.include <mkc_bsd.init.mk>

MAKEINFO?=	makeinfo
INFOFLAGS?=	
INSTALL_INFO?=	install-info

.PHONY:		infoinstall

.SUFFIXES: .txi .texi .texinfo .info

.txi.info .texi.info .texinfo.info:
	${MAKEINFO} ${INFOFLAGS} --no-split -o $@ $<

.if defined(TEXINFO) && !empty(TEXINFO)
INFOFILES=	${TEXINFO:S/.texinfo/.info/g:S/.texi/.info/g:S/.txi/.info/g}
.NOPATH:	${INFOFILES}

.if ${MKINFO} != "no"
realinstall: infoinstall
realall: ${INFOFILES}
.endif

CLEANFILES+=	${INFOFILES}

infoinstall:: ${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}@}
.PRECIOUS: ${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}@}
.if !defined(UPDATE)
.PHONY: ${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}@}
.endif

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

UNINSTALLFILES+=	${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}/${INFONAME_${F}:U${INFONAME:U${F:T}}}@}
INSTALLDIRS+=		${INFOFILES:@F@${DESTDIR}${INFODIR_${F}:U${INFODIR}}@}

.endif

# Make sure all of the standard targets are defined, even if they do nothing.
clean depend includes lint regress tags:

.endif # _MKC_BSD_INFO_MK
