# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc.configure.mk>

.include <mkc_imp.lib.mk>

.if defined(TEXINFO)
.include <mkc_imp.info.mk>
.endif # TEXINFO

.endif # MKC_ERR_MSG
