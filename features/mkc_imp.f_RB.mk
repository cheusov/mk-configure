# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP_F_RB_MK
_MKC_IMP_F_RB_MK := 1

MKC_CHECK_DEFINES +=	RB_ENTRY:sys/tree.h
MKC_CHECK_DEFINES +=	SPLAY_ENTRY:sys/tree.h

CPPFLAGS +=	-D_MKC_CHECK_RB

.endif # _MKC_IMP_F_RB_MK
