# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef MKC_IMP.FINAL.MK
MKC_IMP.FINAL.MK=1

LDADD+=		${DPLIBS}

.if !empty(SRCS:U:M*.l)
.if ${HAVE_FUNCLIB.main.l:U0}
LDADD+=		-ll
.elif ${HAVE_FUNCLIB.main.fl:U0}
LDADD+=		-lfl
.endif
.endif

.if !empty(SRCS:U:M*.y)
.if ${HAVE_CUSTOM.yacc_need_liby:U0}
LDADD+=		-ly
.endif
.endif

.endif # MKC_IMP.FINAL.MK
