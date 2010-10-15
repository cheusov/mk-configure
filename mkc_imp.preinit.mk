# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(SKIP_CONFIGURE_MK) && !make(clean) && !make(cleandir) && !make(distclean)
MKCHECKS?=	yes
.else
MKCHECKS?=	no
.endif # SKIP_CONFIGURE_MK or special targets
