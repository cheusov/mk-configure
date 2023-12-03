.if ${USE_CC:Uauto} == "auto"
PROG.cc  :=	${CC:Ucc:C/^$/cc/}
.else
PROG.cc  :=	${USE_CC}
.endif
CC       :=	${PROG.cc}

.if ${USE_CXX:Uauto} == "auto"
PROG.c++ :=	${CXX:Uc++:C/^$/c++/}
.else
PROG.c++ :=	${USE_CXX}
.endif
CXX      :=	${PROG.c++}

.if ${USE_CPP:Uauto} == "auto"
PROG.cpp :=	${CPP:Ucpp:C/^$/cpp/}
.else
PROG.cpp :=	${USE_CPP}
.endif
CPP      :=	${PROG.cpp}

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
	mkc_imp.objdir.mk mkc_imp.obj.mk mkc_imp.help.mk \
	mkc_imp.compiler_settings.mk mkc.compiler_settings.mk \
	mkc_imp.compiler_type.mk mkc_imp.foreign_autotools.mk ${INFILES} \
	mkc_imp.conf_header_files.mk mkc_imp.conf_headers.mk \
	mkc_imp.conf_funclibs.mk mkc_imp.conf_sizeof.mk \
	mkc_imp.conf_defines.mk mkc_imp.conf_types.mk mkc_imp.conf_vars.mk \
	mkc_imp.conf_members.mk mkc_imp.conf_funcs.mk mkc_imp.conf_custom.mk \
	mkc_imp.conf_progs.mk mkc_imp.conf_prototypes.mk mkc_imp.conf_opts.mk

FILESDIR =	${MKFILESDIR}

INFILES +=	newsys.mk

FILESNAME_newsys.mk =	sys.mk

CLEANFILES +=	mkc_imp.cc_*.mk mkc_imp.cxx_*.mk

#################################################
# the following three variables are necessary for detecting CC_TYPE and CXX_TYPE
#src_type              =	cc cxx

.include <mkc.init.mk>

MKC_NOCACHE=1

.include "mkc_imp.compiler_settings.mk"

post_install:
	for f in ${.OBJDIR}/mkc_imp.cc_*.mk ${.OBJDIR}/mkc_imp.cxx_*.mk; do \
	    test -f "$$f" && \
		${INSTALL} -o ${FILESOWN} -g ${FILESGRP} -m ${FILESMODE} \
		${INSTALL_FLAGS} $$f ${DESTDIR}${MKFILESDIR}; \
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
PROG.nm  =		nm
.  endif
.else
PROG.nm  =		${USE_NM}
.endif

.if empty(USE_ID) || ${USE_ID} == "auto"
.  if exists(/usr/xpg4/bin/id)
PROG.id ?=		/usr/xpg4/bin/id
.  else
PROG.id  =		id
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
INTEXTS_REPLS +=	CC             ${PROG.cc}
INTEXTS_REPLS +=	CXX            ${PROG.c++}
INTEXTS_REPLS +=	CPP            ${PROG.cpp}
INTEXTS_REPLS +=	install        ${install}

#################################################
.include <mkc.mk>
