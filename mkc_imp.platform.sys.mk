# Copyright (c) 2009 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef _MKC_PLATFORM_MK
_MKC_PLATFORM_MK=1

############################################################
.if ${OPSYS} == "Linux"

SHLIB_EXT=	.so

BINMODE?=	755
NONBINMODE?=	644

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

NROFF_MAN2CAT?=	-man

LDFLAGS.shared?=	-G
LDFLAGS.soname?=	-h lib${LIB}${SHLIB_EXT1}

BINMODE?=	755
NONBINMODE?=	644

############################################################
.elif ${OPSYS} == "Darwin"

SHLIB_EXT=	.dylib

COMPILE.s?=	${AS} ${AFLAGS}
COMPILE.S?=	${CC} ${AFLAGS} ${CPPFLAGS} -c

YFLAGS?=	-d

LDFLAGS.shared?=	-dylib
LDFLAGS.soname?=

LDFLAGS_WHOLEARCH?=
LDFLAGS_NOWHOLEARCH?=

SHLIB_EXT?=	.dylib
.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3?=	.${SHLIB_FULLVERSION}.dylib
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}
.endif
.endif

SHLIB_EXTFULL?=	.${SHLIB_FULLVERSION}.dylib

BINMODE?=       755
NONBINMODE?=    644

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

############################################################
############################################################

OBJECT_FMT?=	ELF

# Platform-independent flags for NetBSD a.out shared libraries (and PowerPC)
FFLAGS.pic?= -fPIC
CFLAGS.pic?= -fPIC -DPIC
CPPFLAGS.pic?= -DPIC 
CAFLAGS.pic?= ${CPPFLAGS.pic} ${CFLAGS.pic}
AFLAGS.pic?= -k

# Platform-independent linker flags for ELF shared libraries
.if ${OBJECT_FMT} == "ELF"
LDFLAGS.soname?=		-soname lib${LIB}${SHLIB_EXT1}
.endif

############################################################
############################################################

LDFLAGS.shared?=-shared

NROFF_MAN2CAT?=	-mandoc -Tascii

.endif #_MKC_PLATFORM_MK
