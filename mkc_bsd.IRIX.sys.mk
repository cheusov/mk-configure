# Setting specific to IRIX

RANLIB?=	true

CXX=		CC

.ifndef _IRIXVERS
_IRIXVERS!=	uname -r
.endif
.if !empty(_IRIXVERS:M6*)
CPP?=		CC -E
.else
CPP?=		cpp
.endif

INSTALL?=	mkc_install
