# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_SUBDIR_MK)
_MKC_IMP_SUBDIR_MK=1

.for dir in ${SUBDIR}
__REALSUBDIR+=${dir}
.endfor

__recurse: .USE
	@targ=${.TARGET:C/-.*$//};dir=${.TARGET:C/^[^-]*-//};		\
	test "$${targ}_${MKINSTALL:tl}" = 'install_no' && exit 0;       \
	test "$${targ}_${MKINSTALL:tl}" = 'installdirs_no' && exit 0;   \
	set -e;								\
	echo ==================================================;	\
	case "$$dir" in /*)						\
		echo "$$targ ===> $$dir";				\
		cd "$$dir";						\
		${MAKE} "_THISDIR_=$$dir/" $$targ;			\
		;;							\
	*)								\
		echo "$$targ ===> ${_THISDIR_}$$dir";			\
		cd "${.CURDIR}/$$dir";					\
		${MAKE} "_THISDIR_=${_THISDIR_}$$dir/" $$targ;		\
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
.endif # .WAIT
.endfor # dir

.if defined(__REALSUBDIR)
.PHONY: subdir-${targ}
subdir-${targ}: ${SUBDIR_${targ}}
${targ}: subdir-${targ}
.endif

.endfor # targ

.for dir in ${__REALSUBDIR}
.PHONY: ${dir}
${dir}: all-${dir}
.endfor # dir

# Make sure all of the standard targets are defined, even if they do nothing.
${TARGETS} ${test_target}:

.endif # _MKC_IMP_SUBDIR_MK
