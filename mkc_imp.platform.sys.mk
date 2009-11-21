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
# CC compiler type
.if make(cleandir) || make(distclean) || make(clean)
DISTCLEANFILES+=	_mkc_compiler_type.res
.elif !defined(SKIP_CONFIGURE_MK) && !defined(CC_TYPE) && (defined(PROG) || defined(LIB))
mkc.cc_type.environ= CC='${CC}' CPPFLAGS='${CPPFLAGS}' CFLAGS='${CFLAGS}' LDFLAGS='${LDFLAGS}' LDADD='${LDADD}' MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1
CC_TYPE!=	env ${mkc.cc_type.environ} mkc_check_compiler
.endif

CC_TYPE?=	unknown

cc_type:
	@echo ${CC_TYPE}

SHLIB_EXT.NetBSD=	.so
BINMODE.NetBSD?=	755
NONBINMODE.NetBSD?=	644
INSTALL.NetBSD=		/usr/bin/install

SHLIB_EXT.OpenBSD=	.so
BINMODE.OpenBSD?=	755
NONBINMODE.OpenBSD?=	644
INSTALL.OpenBSD=	/usr/bin/install

SHLIB_EXT.FreeBSD=	.so
BINMODE.FreeBSD?=	755
NONBINMODE.FreeBSD?=	644
INSTALL.FreeBSD=	/usr/bin/install

SHLIB_EXT.DragonFlyBSD=		.so
BINMODE.DragonFlyBSD?=		755
NONBINMODE.DragonFlyBSD?=	644
INSTALL.DragonFlyBSD=		/usr/bin/install

SHLIB_EXT.Linux=	.so
BINMODE.Linux?=		755
NONBINMODE.Linux?=	644
INSTALL.Linux=		install

SHLIB_EXT.SunOS=	.so
BINMODE.SunOS?=		755
NONBINMODE.SunOS?=	644
INSTALL.SunOS=		/usr/ucb/install

SHLIB_EXT.Darwin=	.so
BINMODE.Darwin?=	755
NONBINMODE.Darwin?=	644
INSTALL.Darwin=		/usr/bin/install

.if defined(SHLIB_EXT.${TARGET_OPSYS})
SHLIB_EXT=${SHLIB_EXT.${TARGET_OPSYS}}
.else
SHLIB_EXT=.so
.endif

.if defined(BINMODE.${TARGET_OPSYS})
BINMODE=${BINMODE.${TARGET_OPSYS}}
.else
BINMODE=755
.endif

.if defined(NONBINMODE.${TARGET_OPSYS})
NONBINMODE=${NONBINMODE.${TARGET_OPSYS}}
.else
NONBINMODE=644
.endif

.if defined(INSTALL.${OPSYS})
INSTALL=${INSTALL.${OPSYS}}
.else
INSTALL=mkc_shell
.endif

############################################################
.if ${OPSYS} == "SunOS"

CC?=		gcc
CXX?=		g++
CPP?=		${CC} -E

NROFF_MAN2CAT?=	-man

LDFLAGS.shared?=	-G
LDFLAGS.soname?=	-h lib${LIB}${SHLIB_EXT1}

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

############################################################
.elif ${OPSYS} == "Interix"

SHLIB_EXT=	.so

CFLAGS+=	-D_ALL_SOURCE

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

CC?=	cc

.endif #_MKC_PLATFORM_MK
