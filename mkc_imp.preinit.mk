# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

####################
BMAKE_REQD ?=	20110606

.ifdef MAKE_VERSION
_bmake_ok != test ${MAKE_VERSION} -ge ${BMAKE_REQD} && echo 1 || echo 0
.else
_bmake_ok  = 0
.endif

.if !${_bmake_ok}
.error "bmake-${BMAKE_REQD} or newer is required"
.endif

####################
.if !make(clean) && !make(cleandir) && !make(distclean) && !make(obj)
MKCHECKS ?=	yes
.else
MKCHECKS ?=	no
.endif # clean/cleandir/distclean
