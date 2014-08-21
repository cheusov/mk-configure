FILES =	sys.mk mkc.configure.mk configure.mk mkc.mk \
	mkc.init.mk mkc_imp.intexts.mk mkc_imp.mk \
	mkc.minitest.mk mkc_imp.pkg-config.mk mkc_imp.dpvars.mk \
	mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.prog.mk \
	mkc_imp.subprj.mk mkc_imp.conf-final.mk mkc_imp.rules.mk \
	mkc_imp.final.mk mkc_imp.scripts.mk mkc_imp.checkprogs.mk \
	mkc_imp.platform.sys.mk mkc_imp.dep.mk mkc_imp.lua.mk \
	mkc_imp.arch.mk mkc_imp.pod.mk mkc_imp.preinit.mk \
	mkc.prog.mk mkc.files.mk mkc.lib.mk mkc.subdir.mk mkc.subprj.mk \
	mkc_imp.objdir.mk mkc_imp.obj.mk ${INFILES}

FILESDIR =	${MKFILESDIR}

INFILES +=	mkc_imp.vars.mk

#################################################
.for i in prog_mkdep prog_nbmkdep
MKC_CHECK_CUSTOM   +=	${i}
MKC_CUSTOM_FN.${i}  =	${.CURDIR}/../custom/${i}
.endfor

MKC_CHECK_PROGS    +=	makedepend

.include <mkc.configure.mk>

.if !empty(CUSTOM.prog_nbmkdep)
mkdep_cmd  =		${CUSTOM.prog_nbmkdep}
mkdep_type =		nbmkdep
.elif !empty(CUSTOM.prog_mkdep)
mkdep_cmd  =		${CUSTOM.prog_mkdep}
mkdep_type =		mkdep
.elif ${HAVE_PROG.makedepend:U0}
makedepend_cmd =	${PROG.makedepend}
mkdep_cmd  =		mkdep
mkdep_type =		makedepend
.else
MKC_ERR_MSG +=		"mkdep(1) cannot be found"
.endif

makedepend_cmd ?=	makedepend

INTEXTS_REPLS +=	mkdep_cmd      ${mkdep_cmd}
INTEXTS_REPLS +=	makedepend_cmd ${makedepend_cmd}
INTEXTS_REPLS +=	mkdep_type     ${mkdep_type}
INTEXTS_REPLS +=	featuresdir    ${FEATURESDIR}

#################################################
.include <mkc.mk>
