# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.if defined(MKC_BOOTSTRAP)
.sinclude <configure.mk>
.else
.include <configure.mk>
.endif

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.prog.mk>

.endif # MKC_ERR_MSG
