# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK=1

LDADD+=		${DPLIBS}

.if !empty(SRCS:U:M*.l)
LDADD+=		-ll
.endif

.if !empty(SRCS:U:M*.y)
.if HAVE_CUSTOM.yacc_need_liby
LDADD+=		-ly
.endif
.endif

.endif # MKC_IMP.FINAL.MK
