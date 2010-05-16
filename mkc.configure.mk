# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.ifndef SKIP_CONFIGURE_MK
.if defined(MKC_BOOTSTRAP) || defined(SKIP_CONFIGURE_MK)
.sinclude <configure.mk>
.else
.include <configure.mk>
.endif
.endif

.PHONY: configure
configure: errorcheck
