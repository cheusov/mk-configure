# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.lua.mk>
.include <mkc_imp.init.mk>

.include <configure.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.lib.mk>

.include <mkc_imp.man.mk>
.include <mkc_imp.info.mk>
.include <mkc_imp.files.mk>
.include <mkc_imp.scripts.mk>
.include <mkc_imp.inc.mk>
.include <mkc_imp.links.mk>
.include <mkc_imp.intexts.mk>
.include <mkc_imp.pkg-config.mk>
.include <mkc_imp.dep.mk>
.include <mkc_imp.sys.mk>
.include <mkc_imp.arch.mk>

.include <mkc_imp.final.mk>

.endif # MKC_ERR_MSG
