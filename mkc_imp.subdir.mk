#	$NetBSD: bsd.subdir.mk,v 1.1.1.1 2006/07/14 23:13:01 jlam Exp $
#	@(#)bsd.subdir.mk	8.1 (Berkeley) 6/8/93

.if !defined(_MKC_IMP_SUBDIR_MK)
_MKC_IMP_SUBDIR_MK=1

.include <mkc_imp.init.mk>

.for dir in ${SUBDIR}
.if exists(${dir}.${MACHINE})
__REALSUBDIR+=${dir}.${MACHINE}
.else
__REALSUBDIR+=${dir}
.endif
.endfor

__recurse: .USE
	@targ=${.TARGET:C/-.*$//};dir=${.TARGET:C/^[^-]*-//};		\
	case "$$dir" in /*)						\
		echo "$$targ ===> $$dir";				\
		cd "$$dir";						\
		${MAKE} "_THISDIR_=$$dir/" $$targ;		\
		;;							\
	*)								\
		echo "$$targ ===> ${_THISDIR_}$$dir";			\
		cd "${.CURDIR}/$$dir";					\
		${MAKE} "_THISDIR_=${_THISDIR_}$$dir/" $$targ;	\
		;;							\
	esac

.if !target(test)
test_target=test
.else
test_target=
.endif

# for obscure reasons, we can't do a simple .if ${dir} == ".WAIT"
# but have to assign to __TARGDIR first.
.for targ in ${TARGETS} ${test_target}
.for dir in ${__REALSUBDIR}
__TARGDIR := ${dir}
.if ${__TARGDIR} == ".WAIT"
SUBDIR_${targ} += .WAIT
.else
.PHONY: ${targ}-${dir}
${targ}-${dir}: .MAKE __recurse
SUBDIR_${targ} += ${targ}-${dir}
.endif
.endfor
.if defined(__REALSUBDIR)
.PHONY: subdir-${targ}
subdir-${targ}: ${SUBDIR_${targ}}
${targ}: subdir-${targ}
.endif
.endfor

# Make sure all of the standard targets are defined, even if they do nothing.
${TARGETS} ${test_target}:

.endif # _MKC_IMP_SUBDIR_MK
