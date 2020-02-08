FILES =	mkc.configure.mk mkc.conf.mk mkc_imp.conf-cleanup.mk \
	mkc.mk mkc.init.mk mkc_imp.intexts.mk mkc_imp.mk \
	mkc.minitest.mk mkc_imp.pkg-config.mk mkc_imp.dpvars.mk \
	mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.prog.mk \
	mkc_imp.subprj.mk mkc_imp.conf-final.mk mkc_imp.rules.mk \
	mkc_imp.final.mk mkc_imp.scripts.mk mkc_imp.checkprogs.mk \
	mkc_imp.platform.sys.mk mkc_imp.dep.mk mkc_imp.lua.mk \
	mkc_imp.arch.mk mkc_imp.pod.mk mkc_imp.preinit.mk \
	mkc.prog.mk mkc.files.mk mkc.lib.mk mkc.subdir.mk mkc.subprj.mk \
	mkc_imp.objdir.mk mkc_imp.obj.mk mkc_imp.help.mk ${INFILES}

FILESDIR =	${MKFILESDIR}

INFILES +=	newsys.mk

FILESNAME_newsys.mk =	sys.mk

CLEANFILES +=	mkc_imp.cc_*.mk mkc_imp.cxx_*.mk

#################################################
# the following three variables are necessary for detecting CC_TYPE and CXX_TYPE
src_type              =	c cxx

.include <mkc.init.mk>

USE_CC_COMPILERS  ?=	${CC}
USE_CXX_COMPILERS ?=	${CXX}

.if ${RECURS:U} == 1
.include "compiler_settings.mk"
.endif

.if !defined(RECURS) && (defined(USE_CC_COMPILERS) || defined(USE_CXX_COMPILERS))
post_all:
.for CC in ${USE_CC_COMPILERS:U}
	@env CC=${CC} ${MAKE} ${MAKE_FLAGS} all USE_CXX_COMPILERS= \
	    MKC_NOCACHE=1 RECURS=1 CXX=
.endfor
.for CXX in ${USE_CXX_COMPILERS:U}
	@env CXX=${CXX} ${MAKE} ${MAKE_FLAGS} all USE_CC_COMPILERS= \
	    MKC_NOCACHE=1 RECURS=1 CC=
.endfor
.endif

post_install:
	for f in ${.OBJDIR}/mkc_imp.cc_*.mk ${.OBJDIR}/mkc_imp.cxx_*.mk; do \
	    test -f "$$f" && \
		${INSTALL} -o ${FILESOWN} -g ${FILESGRP} -m ${FILESMODE} \
		${INSTALL_FLAGS} $$f ${MKFILESDIR}; \
	done

#################################################
.for i in prog_mkdep prog_nbmkdep
MKC_CHECK_CUSTOM   +=	${i}
MKC_CUSTOM_FN.${i}  =	${.CURDIR}/../builtins/${i}
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

.if empty(USE_NM) || ${USE_NM} == "auto"
.  if exists(/usr/xpg4/bin/nm)
PROG.nm ?=		/usr/xpg4/bin/nm
.  else
MKC_REQUIRE_PROGS +=	nm
.  endif
.else
PROG.nm  =		${USE_NM}
.endif

.if empty(USE_ID) || ${USE_ID} == "auto"
.  if exists(/usr/xpg4/bin/id)
PROG.id ?=              /usr/xpg4/bin/id
.  else
MKC_REQUIRE_PROGS +=    id
.  endif
.else
PROG.id  =		${USE_ID}
.endif

.if empty(USE_INSTALL) || ${USE_INSTALL} == "auto"
install.NetBSD    =	/usr/bin/install
install.OpenBSD   =	/usr/bin/install
install.FreeBSD   =	/usr/bin/install
install.DragonFly =	/usr/bin/install
install.MirBSD    =	/usr/bin/install
install.Haiku     =	/bin/install
install  ?=		${INSTALL.${TARGET_OPSYS}:Umkc_install}
.elif ${USE_INSTALL} == "mkc_install"
install           =	mkc_install
.else
install           =	${USE_INSTALL}
.endif

makedepend_cmd ?=	makedepend

INTEXTS_REPLS +=	mkdep_cmd      ${mkdep_cmd}
INTEXTS_REPLS +=	makedepend_cmd ${makedepend_cmd}
INTEXTS_REPLS +=	mkdep_type     ${mkdep_type}
INTEXTS_REPLS +=	featuresdir    ${FEATURESDIR}
INTEXTS_REPLS +=	NM             ${PROG.nm}
INTEXTS_REPLS +=	ID             ${PROG.id}
INTEXTS_REPLS +=	install        ${install}

#################################################
.include <mkc.mk>
