# Copyright (c) 2009 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_MAN_MK)
_MKC_IMP_MAN_MK=1

.if ${MKSHARE} == "no"
MKCATPAGES=no
MKDOC=no
MKINFO=no
MKMAN=no
.endif
.if ${MKMAN} == "no"
MKCATPAGES=no
.endif

.if defined(USETBL) && !empty(USETBL:M[Nn][Oo])
.undef USETBL
.endif

.if defined(MANZ) && !empty(MANZ:M[Nn][Oo])
.undef MANZ
.endif

.include <mkc_imp.init.mk>

.PHONY:		catinstall maninstall catpages manpages catlinks manlinks html installhtml
.if ${MKMAN} != "no"
realinstall:	${MANINSTALL}
.endif

TMACDIR?=	/usr/share/groff/tmac
.if exists(${TMACDIR}/tmac.andoc) && exists(${TMACDIR}/tmac.doc)
CATDEPS?=	${TMACDIR}/tmac.andoc \
		${TMACDIR}/tmac.doc
.endif
MANTARGET?=	cat
NROFF?=		nroff
GROFF?=		groff
TBL?=		tbl


.SUFFIXES: .1 .2 .3 .4 .5 .6 .7 .8 .9 \
	   .cat1 .cat2 .cat3 .cat4 .cat5 .cat6 .cat7 .cat8 .cat9 \
	   .html1 .html2 .html3 .html4 .html5 .html6 .html7 .html8 .html9

.9.cat9 .8.cat8 .7.cat7 .6.cat6 .5.cat5 .4.cat4 .3.cat3 .2.cat2 .1.cat1: \
    ${CATDEPS}
.if !defined(USETBL)
	@echo "${NROFF} ${NROFF_MAN2CAT} ${.IMPSRC} > ${.TARGET}"
	@${NROFF} ${NROFF_MAN2CAT} ${.IMPSRC} > ${.TARGET} || \
	 (rm -f ${.TARGET}; false)
.else
	@echo "${TBL} ${.IMPSRC} | ${NROFF} ${NROFF_MAN2CAT} > ${.TARGET}"
	@${TBL} ${.IMPSRC} | ${NROFF} ${NROFF_MAN2CAT} > ${.TARGET} || \
	 (rm -f ${.TARGET}; false)
.endif

.9.html9 .8.html8 .7.html7 .6.html6 .5.html5 .4.html4 .3.html3 .2.html2 .1.html1: \
    ${CATDEPS}
.if !defined(USETBL)
	@echo "${GROFF} -Tascii -mdoc2html -P-b -P-u -P-o ${.IMPSRC} > ${.TARGET}"
	@${GROFF} -Tascii -mdoc2html -P-b -P-u -P-o ${.IMPSRC} > ${.TARGET} || \
	 (rm -f ${.TARGET}; false)
.else
	@echo "${TBL} ${.IMPSRC} | ${GROFF} -mdoc2html -P-b -P-u -P-o > ${.TARGET}"
	@cat ${.IMPSRC} | ${GROFF} -mdoc2html -P-b -P-u -P-o > ${.TARGET} || \
	 (rm -f ${.TARGET}; false)
.endif

.if defined(MAN) && !empty(MAN)
MANPAGES=	${MAN}
CATPAGES=	${MANPAGES:C/(.*).([1-9])/\1.cat\2/}
CLEANFILES+=	${CATPAGES}
.NOPATH:	${CATPAGES}
HTMLPAGES=	${MANPAGES:C/(.*).([1-9])/\1.html\2/}
.endif

MINSTALL=	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
		    -o ${MANOWN} -g ${MANGRP} -m ${MANMODE}

.if defined(MANZ)
# chown and chmod are done afterward automatically
MCOMPRESS=	gzip -cf
MCOMPRESSSUFFIX= .gz
.endif

catinstall: catlinks
maninstall: manlinks

__installpage: .USE
.if defined(MCOMPRESS) && !empty(MCOMPRESS)
	@rm -f ${.TARGET}
	${MCOMPRESS} ${.ALLSRC} > ${.TARGET}
	@chown ${MANOWN}:${MANGRP} ${.TARGET}
	@chmod ${MANMODE} ${.TARGET}
.else
	${MINSTALL} ${.ALLSRC} ${.TARGET}
.endif


# Rules for cat'ed man page installation
.if defined(CATPAGES) && !empty(CATPAGES) && ${MKCATPAGES} != "no"
realall: ${CATPAGES}

.if !empty(MKINSTALL:M[Yy][Ee][Ss])
destination_capages=${CATPAGES:@P@${DESTDIR}${MANDIR}/${P:T:E}${MANSUBDIR}/${P:T:R}.0${MCOMPRESSSUFFIX}@}
.endif # MKINSTALL

catpages:: ${destination_capages}
.PRECIOUS: ${destination_capages}
.PHONY:    ${destination_capages}

UNINSTALLFILES+=	${destination_capages}
INSTALLDIRS+=		${destination_capages:H}

.for P in ${CATPAGES:O:u}
${DESTDIR}${MANDIR}/${P:T:E}${MANSUBDIR}/${P:T:R}.0${MCOMPRESSSUFFIX}: ${P} __installpage
.endfor

.else
catpages::
.endif # CATPAGES

# Rules for source page installation
.if defined(MANPAGES) && !empty(MANPAGES)

.if !empty(MKINSTALL:M[Yy][Ee][Ss])
destination_manpages=${MANPAGES:@P@${DESTDIR}${MANDIR}/man${P:T:E}${MANSUBDIR}/${P}${MCOMPRESSSUFFIX}@}
.endif # MKINSTALL

manpages:: ${destination_manpages}
.PRECIOUS: ${destination_manpages}
.PHONY:    ${destination_manpages}

UNINSTALLFILES+=	${destination_manpages}
INSTALLDIRS+=		${destination_manpages:H}

.for P in ${MANPAGES:O:u}
${DESTDIR}${MANDIR}/man${P:T:E}${MANSUBDIR}/${P}${MCOMPRESSSUFFIX}: ${P} __installpage
.endfor

.else
manpages::
.endif # MANPAGES

.if ${MKCATPAGES} != "no"
catlinks: catpages
.if defined(MLINKS) && !empty(MLINKS)
	@set ${MLINKS}; \
	while test $$# -ge 2; do \
		name=$$1; \
		shift; \
		dir=${DESTDIR}${MANDIR}/cat$${name##*.}; \
		l=$${dir}${MANSUBDIR}/$${name%.*}.0${MCOMPRESSSUFFIX}; \
		name=$$1; \
		shift; \
		dir=${DESTDIR}${MANDIR}/cat$${name##*.}; \
		t=$${dir}${MANSUBDIR}/$${name%.*}.0${MCOMPRESSSUFFIX}; \
		if test $$l -nt $$t -o ! -f $$t; then \
			echo $$t -\> $$l; \
			ln -f $$l $$t; \
		fi; \
	done
.endif
.else
catlinks:
.endif

manlinks: manpages
.if defined(MLINKS) && !empty(MLINKS)
	@set ${MLINKS}; \
	while test $$# -ge 2; do \
		name=$$1; \
		shift; \
		dir=${DESTDIR}${MANDIR}/man$${name##*.}; \
		l=$${dir}${MANSUBDIR}/$${name}${MCOMPRESSSUFFIX}; \
		name=$$1; \
		shift; \
		dir=${DESTDIR}${MANDIR}/man$${name##*.}; \
		t=$${dir}${MANSUBDIR}/$${name}${MCOMPRESSSUFFIX}; \
		if test $$l -nt $$t -o ! -f $$t; then \
			echo $$t -\> $$l; \
			ln -f $$l $$t; \
		fi; \
	done
.endif

# Html rules
html: ${HTMLPAGES}

.if defined(HTMLPAGES) && !empty(HTMLPAGES)
.for P in ${HTMLPAGES:O:u} 
${DESTDIR}${HTMLDIR}/${P:T:E}/${P:T:R}.html: ${P}
	${MINSTALL} ${.ALLSRC} ${.TARGET}
.endfor

.if !empty(MKINSTALL:M[Yy][Ee][Ss])
destination_htmls=${HTMLPAGES:@P@${DESTDIR}${HTMLDIR}/${P:T:E}/${P:T:R}.html@}
.endif

installhtml:            ${destination_htmls}
UNINSTALLFILES+=	${destination_htmls}
INSTALLDIRS+=		${destination_htmls:H}

CLEANFILES+=	${HTMLPAGES}

.if !empty(MKHTML:M[Yy][Ee][Ss])
realinstall: installhtml
realall: ${HTMLPAGES}
.endif # MKHTML
.endif # HTMLPAGES

realall:

.endif # _MKC_IMP_MAN_MK
