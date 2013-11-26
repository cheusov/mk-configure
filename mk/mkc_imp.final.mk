# Copyright (c) 2009-2012 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK = 1

LDADD +=	${DPLIBS} # DPLIBS is deprecated (2012-08-13)
LDADD +=	${LDADD_${PROJECTNAME}}

LDFLAGS +=	${LDFLAGS_${PROJECTNAME}}

.if !empty(SRCS:U:M*.l)
LDADD +=	${LEXLIB}
.endif

.for i in ${EXPORT_VARNAMES}
.if empty(NOEXPORT_VARNAMES:U:M${i})
export_cmd  +=	${i}=${${i}:Q}; export ${i};
.endif
.endfor

##########
.if !commands(clean)
clean: mkc_clean
.endif

mkc_clean:
.if ${CLEANFILES:U} != ""
	-rm -f ${CLEANFILES} 2>/dev/null
.endif
.if ${CLEANDIRS:U} != ""
	-rm -rf ${CLEANDIRS} 2>/dev/null
.endif

#####
distclean: cleandir
.if !commands(cleandir)
cleandir: mkc_cleandir
.endif

mkc_cleandir:
.if ${CLEANFILES:U} != "" || ${DISTCLEANFILES:U} != ""
	-rm -f ${DISTCLEANFILES} ${CLEANFILES} 2>/dev/null
.endif
.if ${CLEANDIRS:U} != "" || ${DISTCLEANDIRS:U} != ""
	-rm -rf ${DISTCLEANDIRS} ${CLEANDIRS} 2>/dev/null
.endif

##########

.endif # MKC_IMP.FINAL.MK
