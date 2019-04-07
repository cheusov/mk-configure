# Copyright (c) 2009-2012 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK = 1

.PATH: ${SRC_PATHADD}

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
realdo_clean: mkc_clean

mkc_clean: .PHONY
.if ${CLEANFILES:U} != ""
	-${CLEANFILES_CMD} ${CLEANFILES}
.endif
.if ${CLEANDIRS:U} != ""
	-${CLEANDIRS_CMD} ${CLEANDIRS}
.endif

#####
distclean: cleandir

realdo_cleandir: mkc_cleandir

mkc_cleandir:
.if ${CLEANFILES:U} != "" || ${DISTCLEANFILES:U} != ""
	-${CLEANFILES_CMD} ${DISTCLEANFILES} ${CLEANFILES}
.endif
.if ${CLEANDIRS:U} != "" || ${DISTCLEANDIRS:U} != ""
	-${CLEANDIRS_CMD} ${DISTCLEANDIRS} ${CLEANDIRS}
.endif

##########
# pre_, do_, post_ targets
.for t in ${ALLTARGETS}
${t}: pre_${t} .WAIT do_${t} .WAIT post_${t}
pre_${t} do_${t} realdo_${t} post_${t}: .PHONY # ensure existence
.if !commands(do_${t})
do_${t}: realdo_${t}
.endif
.endfor

${TARGETS}: .PHONY

##########

.endif # MKC_IMP.FINAL.MK
