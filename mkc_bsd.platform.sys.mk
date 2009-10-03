.ifndef _MKC_PLATFORM_MK
_MKC_PLATFORM_MK=1

############################################################
.if ${OPSYS} == "Linux"

SHLIB_EXT=	.so

############################################################
.elif ${OPSYS} == "NetBSD"

SHLIB_EXT=	.so

.if ${MACHINE_ARCH:U} == "sparc64" 
AFLAGS+= -Wa,-Av9a
.endif

############################################################
.elif ${OPSYS} == "FreeBSD"

SHLIB_EXT=	.so

############################################################
.elif ${OPSYS} == "OpenBSD"

SHLIB_EXT=	.so

############################################################
.elif ${OPSYS} == "SunOS"

SHLIB_EXT=	.so

COMPILE.S?=	${AS} ${AFLAGS} ${CPPFLAGS} -P
CC?=		gcc
CXX?=		g++
CPP?=		${CC} -E
INSTALL?=	/usr/ucb/install

############################################################
.elif ${OPSYS} == "Darwin"

SHLIB_EXT=	.dylib

COMPILE.s?=	${AS} ${AFLAGS}
COMPILE.S?=	${CC} ${AFLAGS} ${CPPFLAGS} -c

YFLAGS?=	-d

LDFLAGS_SHARED?=	-dylib
SHLIB_SHFLAGS?=

LINTFLAGS?=	-chapbx

LDFLAGS_WHOLEARCH?=
LDFLAGS_NOWHOLEARCH?=

SHLIB_EXT?=	.dylib
.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3?=	.${SHLIB_FULLVERSION}.dylib
.endif
.endif
.endif

SHLIB_EXTFULL?=	.${SHLIB_FULLVERSION}.dylib

############################################################
.elif ${OPSYS} == "Interix"

SHLIB_EXT=	.so

CFLAGS+=	-D_ALL_SOURCE
INSTALL=	mkc_shell

############################################################
.elif ${OPSYS} == "UnixWare"

CC?=		gcc
CXX?=		g++
FC?=		g77
# gcc on Unixware has no internal macro to identify the system
CFLAGS?=	-DUNIXWARE ${DBG}
CXXFLAGS?=	-DUNIXWARE ${CFLAGS}
CPPFLAGS?=	-DUNIXWARE
#
INSTALL?=	/usr/ucb/install

############################################################
.elif ${OPSYS} == "OSF1"

CXX?=		cxx
CPP?=		${CC} -E
INSTALL?=	mkc_install

############################################################
.elif ${OPSYS} == "Minix"

############################################################
.elif ${OPSYS} == "IRIX"

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

############################################################
.elif ${OPSYS} == "HPUX"

############################################################
.elif ${OPSYS} == "AIX"

CPP?=		${CC} -E
INSTALL?=	mkc_install

.endif

############################################################
############################################################

.if defined(SHLIB_EXT) && !empty(SHLIB_EXT)

.if ${SHLIB_EXT} == ".so"

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1=	.so.${SHLIB_MAJOR}
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2=	.so.${SHLIB_MAJOR}.${SHLIB_MINOR}
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
SHLIB_EXT3=	.so.${SHLIB_FULLVERSION}
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}
.endif
.endif

SHLIB_EXTFULL=	.so.${SHLIB_FULLVERSION}

.endif # SHLIB_EXT

.endif # defined(SHLIB_EXT)

.endif #_MKC_PLATFORM_MK
