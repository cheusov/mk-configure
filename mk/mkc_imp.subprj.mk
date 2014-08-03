# Copyright (c) 2010-2013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_MKC_IMP_SUBPRJ_MK)
_MKC_IMP_SUBPRJ_MK := 1

.for dir in ${SUBPRJ:S/:/ /g}
.if empty(NOSUBDIR:U:M${dir})
__REALSUBPRJ += ${dir}
.endif
.endfor

.for dir in ${NOSUBDIR}
NODEPS +=	*-${dir}:* *:*-${dir}   *-*/${dir}:* *:*-*/${dir}
.endfor

.ifndef SUBDIR
__REALSUBPRJ := ${__REALSUBPRJ:O:u}
.endif

.if !empty(__REALSUBPRJ:M*-*)
.error "Dash symbol is not allowed inside subdir (${__REALSUBPRJ:M*-*})"
.endif

SUBPRJ_DFLT ?=	${__REALSUBPRJ}

.for targ in ${TARGETS}
.for dir in ${__REALSUBPRJ:N.WAIT}
_ALLTARGDEPS3 +=	${targ}-${dir}
.PHONY: nodeps-${targ}-${dir}   subdir-${targ}-${dir}   ${targ}-${dir}
nodeps-${targ}-${dir}: .MAKE __recurse
       ${targ}-${dir}: .MAKE __recurse
subdir-${targ}-${dir}: .MAKE __recurse
.if ${SHORTPRJNAME:tl} == "yes" && ${dir} != ${dir:T}
_ALLTARGDEPS3 +=	${targ}-${dir:T}
.PHONY: nodeps-${targ}-${dir:T} subdir-${targ}-${dir:T} ${targ}-${dir:T}
nodeps-${targ}-${dir:T}: nodeps-${targ}-${dir}
       ${targ}-${dir:T}:        ${targ}-${dir}
subdir-${targ}-${dir:T}: subdir-${targ}-${dir}
_ALLTARGDEPS3 +=	${targ}-${dir}:${targ}-${dir:T}
.endif
.endfor # dir

.if !commands(${targ})
. for dir in ${SUBPRJ_DFLT}
dir_ = ${dir}
.  if ${dir_} == ".WAIT"
_SUBDIR_${targ} += .WAIT
.  else
_SUBDIR_${targ} += ${targ}-${dir}:${targ}
.  endif # .WAIT
. endfor # dir
.for excl in ${NODEPS}
_SUBDIR_${targ} :=	${_SUBDIR_${targ}:N${excl}}
.endfor # excl
_ALLTARGDEPS2 += ${_SUBDIR_${targ}}
${targ}: ${_SUBDIR_${targ}:S/:${targ}$//}
.endif #!command(${targ})

.for dep prj in ${SUBPRJ:M*\:*:S/:/ /}
_ALLTARGDEPS += ${targ}-${dep}:${targ}-${prj}
.endfor # dep prj

.endfor # targ

.for dir in ${__REALSUBPRJ}
.if ${SHORTPRJNAME:tl} == "yes" && ${dir:T} != ${dir}
SRCDIR_${dir:T}  =	${.CURDIR}/${dir}
EXPORT_VARNAMES +=	SRCDIR_${dir:T}
_ALLTARGDEPS    +=	all-${dir}:${dir:T}
_ALLTARGDEPS3   +=	${dir:T}
.endif # .if ${SHORTPRJNAME:tl} == "yes" ...
j:=${dir:S,/,_,g}
.if empty(j:M*[.]*)
SRCDIR_${j} = ${.CURDIR}/${dir}
EXPORT_VARNAMES += SRCDIR_${dir:S,/,_,g}
.endif # .if dir contains .
_ALLTARGDEPS += all-${dir}:${dir}
.endfor # dir

.for excl in ${NODEPS}
_ALLTARGDEPS :=	${_ALLTARGDEPS:N${excl}}
.endfor # excl

.for deptarg prjtarg in ${_ALLTARGDEPS:S/:/ /}
.PHONY: ${prjtarg} ${deptarg}
${prjtarg}: ${deptarg}
.endfor

.PHONY: print_deps
print_deps:
.for i in ${_ALLTARGDEPS} ${_ALLTARGDEPS2} ${_ALLTARGDEPS3} ${TARGETS}
	@echo ${i:S/:/ /}
.endfor

__recurse: .USE
	@targ=${.TARGET:S/^nodeps-//:C/-.*$//};				\
	dir=${.TARGET:S/^nodeps-//:C/^[^-]*-//};			\
	if ! test -f ${.CURDIR}/$$dir/Makefile; then exit 0; fi;	\
	test "$${targ}_${MKINSTALL:tl}" = 'install_no' && exit 0;       \
	test "$${targ}_${MKINSTALL:tl}" = 'installdirs_no' && exit 0;	\
	${export_cmd}							\
	set -e;								\
	${VERBOSE_ECHO} ================================================== 1>&2;\
	case "$$dir" in /*)						\
		${VERBOSE_ECHO} "$$targ ===> $$dir" 1>&2;		\
		cd "$$dir";						\
		env "_THISDIR_=$$dir/" ${MAKE} ${MAKEFLAGS} $$targ;		\
		;;							\
	*)								\
		${VERBOSE_ECHO} "$$targ ===> ${_THISDIR_}$$dir" 1>&2;	\
		cd "${.CURDIR}/$$dir";					\
		env "_THISDIR_=${_THISDIR_}$$dir/" ${MAKE} ${MAKEFLAGS} $$targ; \
		;;							\
	esac

###########
SUBPRJSRCTOP =	${.CURDIR}
.export SUBPRJSRCTOP
###########

.include <mkc_imp.objdir.mk>

.endif # _MKC_IMP_SUBPRJ_MK
