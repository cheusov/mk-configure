# Copyright (c) 2009-2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.include "mkc_imp.preinit.mk"

.if make(distclean)
.warning "Target 'distclean' is deprecated, please use 'cleandir'"
.endif

.ifdef SUBDIR
  SUBPRJ = ${SUBDIR}
.endif

.if !empty(LUA_LMODULES) || !empty(LUA_CMODULES) || !empty(LUA_MODULES)
.  include "mkc_imp.lua.mk"
.endif

.include "mkc_imp.pod.mk"
.include "mkc.init.mk"

.if ${MKCHECKS:tl} == "yes"
.ifdef AXCIENT_LIBDEPS # This feature was proposed by axcient.com developers
CHECK_COMMON_SH_DIR ?=	${MKC_LIBEXECDIR}
all_deps != ${CHECK_COMMON_SH_DIR}/mkc_get_deps ${.CURDIR:S,^${SUBPRJSRCTOP}/,,}
.  for p in ${all_deps}
     _mkfile =	${SUBPRJSRCTOP}/${p}/linkme.mk
.    if exists(${_mkfile})
.      include "${_mkfile}"
.    endif
     DPLDADD   ?=	${p:T:S/^lib//}
     DPLIBDIRS ?=	${OBJDIR_${p:S,/,_,g}}
     DPINCDIRS ?=	${SRCDIR_${p:S,/,_,g}} ${OBJDIR_${p:S,/,_,g}}
     _LIBDEPSDONEFILES :=	${_LIBDEPSDONEFILES} ${DPLIBDIRS}/${p:T}.done
.    include "mkc_imp.dpvars.mk"
.  endfor
.endif
.endif

.if defined(LIBDEPS)
  SUBPRJ          +=	${LIBDEPS} # library dependencies
  AXCIENT_LIBDEPS :=	${LIBDEPS}
  EXPORT_VARNAMES +=	AXCIENT_LIBDEPS
.endif # defined(LIBDEPS)

.if !defined(LIB) && !defined(SUBPRJ)
  _use_prog :=	1
.endif

.ifdef FOREIGN
.  include "mkc_imp.foreign_${FOREIGN}.mk"
.endif
.include "mkc_imp.rules.mk"
.include "mkc_imp.obj.mk"

# Make sure all of the standard targets are defined, even if they do nothing.
do_install1 do_install2: .PHONY

distclean:	.PHONY cleandir

.if ${MKINSTALLDIRS:tl} == "yes"
install: pre_installdirs .WAIT do_installdirs .WAIT post_installdirs .WAIT \
         pre_install .WAIT do_install .WAIT post_install
.endif

realdo_install: do_install1 .WAIT do_install2

# skip uninstalling files and creating destination dirs for mkc.subprj.mk
.if !defined(SUBPRJ)

realdo_uninstall:
	-${UNINSTALL} ${UNINSTALLFILES}

realdo_installdirs:

filelist:
	@for d in ${UNINSTALLFILES:O:u}; do \
		echo $$d; \
	done

test:

.endif # !SUBPRJ

###########
.PHONY : print_values
print_values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

.PHONY : print_values2
print_values2 :
.for v in ${VARS}
	@printf "%s\n" ${${v}:Q}
.endfor

${.CURDIR:T}.done:
	@printf '' > $@

###########
check_mkc_err_msg:
	@if test -n '${MKC_ERR_MSG}'; then \
	    for msg in '' ${MKC_ERR_MSG}; do \
		fn=`printf '%s\n' "$$msg" | sed -n 's/^%%%: //p'`; \
		if test -n "$$fn"; then \
		    awk '{print "ERROR: " $$0}' "$$fn"; ex=1; \
		elif test -n "$$msg"; then printf '%s\n' "$$msg"; ex=1; \
		fi; \
	    done 1>&2; \
	    exit $$ex; \
	fi

all: pre_configure .WAIT do_configure .WAIT post_configure .WAIT pre_all .WAIT do_all .WAIT post_all
realdo_configure: check_mkc_err_msg

.include "mkc_imp.checkprogs.mk"
.include "mkc.conf.mk"

# features
.for f in ${MKC_FEATURES}
.  include <mkc_imp.f_${f}.mk>
.endfor
.include "mkc.conf.mk"
.include "mkc_imp.conf-final.mk"
CPPFLAGS +=	${MKC_FEATURES:D-I${FEATURESDIR}}

.if !defined(MKC_ERR_MSG) || ${MKCHECKS} == "no"

.  if defined(LIB)
.    include "mkc_imp.lib.mk"
.  elif defined(_use_prog)
.    include "mkc_imp.prog.mk"
.  endif

.  if defined(_use_prog) || defined(LIB)
.if !empty(MAN)
.    include "mkc_imp.man.mk"
.else
# for backward compatibility with my own tools (2020-12-10)
# and should be depeted.
.PHONY: manpages
manpages:
.endif

.if !empty(TEXINFO)
.    include "mkc_imp.info.mk"
.endif

.if !empty(INCS)
.    include "mkc_imp.inc.mk"
.endif

.if !empty(INFILES) || !empty(INSCRIPTS)
.    include "mkc_imp.intexts.mk"
.endif

.if !empty(MKC_REQUIRE_PKGCONFIG) || !empty(MKC_CHECK_PKGCONFIG)
.    include "mkc_imp.pkg-config.mk"
.endif

.    include "mkc_imp.dep.mk"

.if !empty(FILES)
.    include "mkc_imp.files.mk"
.endif

.if !empty(SCRIPTS)
.    include "mkc_imp.scripts.mk"
.endif

.if !empty(LINKS) || !empty(SYMLINKS)
.    include "mkc_imp.links.mk"
.endif
.  endif # _use_prog || LIB

   ########################################
.  if defined(SUBPRJ)
.    include "mkc_imp.subprj.mk"
.  endif # SUBPRJ
   ########################################

.  include "mkc_imp.arch.mk"
.  include "mkc_imp.help.mk"

.endif # MKC_ERR_MSG

.include "mkc_imp.final.mk"
