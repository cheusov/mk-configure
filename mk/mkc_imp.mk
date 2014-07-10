# Copyright (c) 2009-2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
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

.include <mkc_imp.lua.mk>
.include <mkc_imp.pod.mk>

.include <mkc.init.mk>
.include <mkc_imp.rules.mk>
.include <mkc_imp.obj.mk>

# Make sure all of the standard targets are defined, even if they do nothing.
.PHONY: ${TARGETS} pre_install do_install do_install1 do_install2 post_install do_all pre_uninstall do_uninstall post_uninstall
${TARGETS} pre_install do_install do_install1 do_install2 post_install do_all pre_uninstall do_uninstall post_uninstall:

distclean:	cleandir

all:		pre_all .WAIT do_all .WAIT post_all
pre_all do_all post_all: # ensure existence

.if ${MKINSTALLDIRS:tl} == "yes"
install: pre_installdirs .WAIT do_installdirs .WAIT post_installdirs .WAIT \
         pre_install .WAIT do_install .WAIT post_install
.else
install: pre_install .WAIT do_install .WAIT post_install
.endif

.if !commands(do_install)
do_install: do_install1 .WAIT do_install2
.endif

pre_installdirs do_installdirs post_installdirs: # ensure existence

# skip uninstalling files and creating destination dirs for mkc.subprj.mk
.if !defined(SUBPRJ)

.PHONY: pre_uninstall do_uninstall post_uninstall
uninstall: pre_uninstall .WAIT do_uninstall .WAIT post_uninstall

.if !commands(do_uninstall)
do_uninstall:
	-${UNINSTALL} ${UNINSTALLFILES}
.endif

installdirs: pre_installdirs .WAIT do_installdirs .WAIT post_installdirs

.if !commands(do_installdirs)
do_installdirs:
	for d in _ ${INSTALLDIRS:O:u:S|/.$||}; do \
		test "$$d" = _ || ${INSTALL} -d -m ${DIRMODE} "$$d"; \
	done
.endif

filelist:
	@for d in ${UNINSTALLFILES:O:u}; do \
		echo $$d; \
	done

test:

.endif # SUBPRJ

###########
.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

.PHONY : print-values2
print-values2 :
.for v in ${VARS}
	@printf "%s\n" ${${v}:Q}
.endfor

###########
.PHONY: do_all realerrorcheck

__errorcheck: .USE
	@if test -n '${MKC_ERR_MSG}'; then \
	    for msg in '' ${MKC_ERR_MSG}; do \
		fn=`printf '%s\n' "$$msg" | sed -n 's/^%%%: //p'`; \
		if test -n "$$fn"; then \
		    awk '{print "ERROR: " $$0}' "$$fn"; ex=1; \
		elif test -n "$$msg"; then printf '%s\n' "$$msg"; ex=1; \
		fi; \
	    done; \
	    exit $$ex; \
	fi

do_all : realerrorcheck
realerrorcheck: __errorcheck

.include <mkc_imp.checkprogs.mk>
.include <configure.mk>

# features
.for f in ${MKC_FEATURES}
.include <mkc_imp.f_${f}.mk>
.endfor
.include <configure.mk>
CFLAGS +=	${MKC_FEATURES:D-I${FEATURESDIR}}

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.if defined(LIB)
.include <mkc_imp.lib.mk>
.elif defined(_use_prog)
.include <mkc_imp.prog.mk>
.endif

.if defined(_use_prog) || defined(LIB)
.include <mkc_imp.man.mk>
.include <mkc_imp.info.mk>
.include <mkc_imp.inc.mk>
.include <mkc_imp.intexts.mk>
.include <mkc_imp.pkg-config.mk>
.include <mkc_imp.dep.mk>
.include <mkc_imp.files.mk>
.include <mkc_imp.scripts.mk>
.include <mkc_imp.links.mk>
.endif # _use_prog || LIB

########################################
.if defined(SUBPRJ)
.include <mkc_imp.subprj.mk>
.endif # SUBPRJ
########################################

.include <mkc_imp.arch.mk>
.include <mkc_imp.final.mk>
#

.endif # MKC_ERR_MSG
