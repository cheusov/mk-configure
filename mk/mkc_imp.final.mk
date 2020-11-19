# Copyright (c) 2009-2012 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK = 1

.PATH: ${SRC_PATHADD}

.if !empty(DISTCLEANFILES)
.warning "DISTCLEANFILES variable is deprecated since 2020-11-19, please use CLEANDIRFILES"
.endif
.if !empty(DISTCLEANDIRS)
.warning "DISTCLEANDIRS variable is deprecated since 2020-11-19, please use CLEANDIRDIRS"
.endif

LDADD +=	${LDADD_${PROJECTNAME}}

LDFLAGS +=	${LDFLAGS_${PROJECTNAME}}

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
.PHONY: errorcheck
errorcheck: configure

realdo_cleandir: mkc_cleandir

mkc_cleandir:
.if ${CLEANFILES:U} != "" || ${CLEANDIRFILES:U} != ""
	-${CLEANFILES_CMD} ${CLEANDIRFILES} ${CLEANFILES}
.endif
.if ${CLEANDIRS:U} != "" || ${CLEANDIRDIRS:U} != ""
	-${CLEANDIRS_CMD} ${CLEANDIRDIRS} ${CLEANDIRS}
.endif

##########
# pre_, do_, post_ targets
.for t in ${ALLTARGETS}
${t}: pre_${t} .WAIT do_${t} .WAIT post_${t}
pre_${t} do_${t} realdo_${t} post_${t}: .PHONY # ensure existence
.if !commands(do_${t})
do_${t}: realdo_${t}
.endif # !command
.endfor # t

${TARGETS}: .PHONY

##########

.endif # MKC_IMP.FINAL.MK
