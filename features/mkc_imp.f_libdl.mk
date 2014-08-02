# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_LIBDL_MK
_MKC_IMP_F_LIBDL_MK := 1

MKC_COMMON_DEFINES += -D_GNU_SOURCE

MKC_REQUIRE_FUNCLIBS +=	dlopen:dl
MKC_REQUIRE_FUNCS2   +=	dlopen:dlfcn.h

.endif # _MKC_IMP_F_LIBDL_MK
