# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.include <configure.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.lib.mk>

.endif # MKC_ERR_MSG
