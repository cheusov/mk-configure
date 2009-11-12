# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.ifndef SKIP_CONFIGURE_MK

.include <configure.mk>

.endif

.PHONY: configure
configure: error-check
