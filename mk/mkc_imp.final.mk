# Copyright (c) 2009-2012 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK = 1

.PATH: ${SRC_PATHADD}

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

.if ${MKRELOBJDIR} == "yes" && defined(SRCTOP)
export_cmd  +=	MAKEOBJDIR=${.OBJDIR}/${.TARGET:C/^.*-//}; \
	export MAKEOBJDIR; ${MKDIR} -p $${MAKEOBJDIR};
.endif

##########
.if !commands(clean)
clean: mkc_clean
.endif

mkc_clean:
.if ${CLEANFILES:U} != ""
	-${CLEANFILES_CMD} ${CLEANFILES}
.endif
.if ${CLEANDIRS:U} != ""
	-${CLEANDIRS_CMD} ${CLEANDIRS}
.endif

#####
distclean: cleandir
.if !commands(cleandir)
cleandir: mkc_cleandir
.endif

mkc_cleandir:
.if ${CLEANFILES:U} != "" || ${DISTCLEANFILES:U} != ""
	-${CLEANFILES_CMD} ${DISTCLEANFILES} ${CLEANFILES}
.endif
.if ${CLEANDIRS:U} != "" || ${DISTCLEANDIRS:U} != ""
	-${CLEANDIRS_CMD} ${DISTCLEANDIRS} ${CLEANDIRS}
.endif

##########

.endif # MKC_IMP.FINAL.MK
