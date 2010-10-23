# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK=1

LDADD+=		${DPLIBS}

.if !empty(SRCS:U:M*.l)
LDADD+=		${LEXLIB}
.endif

.endif # MKC_IMP.FINAL.MK
