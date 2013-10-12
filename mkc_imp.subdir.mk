# Copyright (c) 2009-2013 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_SUBDIR_MK)
_MKC_IMP_SUBDIR_MK := 1

.for dir in ${SUBDIR}
.if empty(NOSUBDIR:U:M${dir})
SUBPRJ += ${dir}
.endif
.endfor

.include <mkc_imp.subprj.mk>

.endif # _MKC_IMP_SUBDIR_MK
