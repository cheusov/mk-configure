# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################
.include <mkc_imp.preinit.mk>

.ifdef SUBDIR
SUBPRJ = ${SUBDIR}
.endif

.ifdef SUBPRJS
SUBPRJ   +=	${SUBPRJS} # for backward compatility only, use SUBPRJ!
.endif # defined(SUBPRJS)

.if !defined(LIB) && !defined(SUBPRJ)
_use_prog :=	1
.endif

.if defined(_use_prog) || defined(LIB)
.include <mkc_imp.lua.mk>
.include <mkc_imp.pod.mk>
.endif # _use_prog || LIB

.include <mkc_imp.init.mk>

CLEANFILES += ${MKC_SOURCE_FUNCLIBS:D${MKC_SOURCE_FUNCLIBS}.o}
.if ${MKCHECKS:tl} == "yes"
.include <configure.mk>
.endif # MKCHECKS

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.if defined(LIB)
.include <mkc_imp.lib.mk>
.elif defined(_use_prog)
.include <mkc_imp.prog.mk>
.endif

.if defined(_use_prog) || defined(LIB)
.include <mkc_imp.man.mk>
.include <mkc_imp.info.mk>
.include <mkc_imp.files.mk>
.include <mkc_imp.scripts.mk>
.include <mkc_imp.inc.mk>
.include <mkc_imp.links.mk>
.include <mkc_imp.intexts.mk>
.include <mkc_imp.pkg-config.mk>
.include <mkc_imp.dep.mk>
.include <mkc_imp.sys.mk>
.endif # _use_prog || LIB

########################################
.if defined(SUBPRJ)
.include <mkc_imp.subprj.mk>

#
.PHONY: subprj-clean subprj-distclean
clean: subprj-clean
subprj-clean:
	-rm -f ${CLEANFILES} 2>/dev/null
cleandir: subprj-distclean
subprj-distclean:
	-rm -f ${DISTCLEANFILES} 2>/dev/null

.endif # SUBPRJ
########################################

.include <mkc_imp.arch.mk>
.include <mkc_imp.final.mk>
#

.endif # MKC_ERR_MSG
