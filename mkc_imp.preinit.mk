# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.if !make(clean) && !make(cleandir) && !make(distclean)
MKCHECKS ?=	yes
.else
MKCHECKS ?=	no
.endif # clean/cleandir/distclean
