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

####################
SHLIB_EXT.Darwin=	.dylib

SHLIB_EXT?=		${SHLIB_EXT.${TARGET_OPSYS}:U.so}

####################
BINMODE.Interix=	775
NONBINMODE.Interix=	664

BINMODE?=		${BINMODE.${TARGET_OPSYS}:U755}
NONBINMODE?=		${BINMODE.${TARGET_OPSYS}:U644}

####################
INSTALL.NetBSD=		/usr/bin/install
INSTALL.OpenBSD=	/usr/bin/install
INSTALL.FreeBSD=	/usr/bin/install
INSTALL.DragonFlyBSD=	/usr/bin/install
INSTALL.Linux=		install
INSTALL.Darwin=		/usr/bin/install
INSTALL.SunOS=		/usr/ucb/install
INSTALL.UnixWare=	/usr/ucb/install

INSTALL?=		${INSTALL.${TARGET_OPSYS}:Umkc_install}

# The following line is for debugging only
INSTALL=		mkc_install

####################

.if !defined(CC.SunOS)
.if exists(/usr/ccs/bin/cc)
CC.SunOS=	/usr/ccs/bin/cc
.elif exists(/opt/SUNWspro/bin/cc)
CC.SunOS=	/opt/SUNWspro/bin/cc
.elif exists(/usr/sfw/bin/gcc)
CC.SunOS=	/usr/sfw/bin/gcc
.else
CC.SunOS=	cc
.endif # exists...
.endif # defined(CC.SunOS)

.if !defined(CXX.SunOS)
.if exists(/usr/ccs/bin/CC)
CXX.SunOS=	/usr/ccs/bin/CC
.elif exists(/opt/SUNWspro/bin/CC)
CXX.SunOS=	/opt/SUNWspro/bin/CC
.elif exists(/usr/sfw/bin/g++)
CXX.SunOS=	/usr/sfw/bin/g++
.else
CXX.SunOS=	c++
.endif # exists...
.endif # defined(CC.SunOS)

CPP.SunOS=	${CC} -E

CC.UnixWare=	gcc
CXX.UnixWare=	g++
CPP.UnixWare=	${CC} -E

CXX.OSF1=	cxx
CPP.OSF1=	${CC} -E

CXX.IRIX=	CC

CPP.AIX=	${CC} -E

CC?=		${CC.${TARGET_OPSYS}:Ucc}
CXX?=		${CXX.${TARGET_OPSYS}:Uc++}
CPP?=		${CPP.${TARGET_OPSYS}:Ucpp}

####################
CPPFLAGS.Interix=	-D_ALL_SOURCE
CPPFLAGS.UnixWare=	-DUNIXWARE

CPPFLAGS+=	${CPPFLAGS.${TARGET_OPSYS}:U}

####################
#FFLAGS.pic?= -fPIC

####################
CFLAGS.pic.gcc?=	-fPIC -DPIC
CPPFLAGS.pic.gcc?=	-DPIC

CFLAGS.pic.icc?=	-fPIC -DPIC
CPPFLAGS.pic.icc?=	-DPIC

CFLAGS.pic.pcc?=	-k -DPIC
CPPFLAGS.pic.pcc?=	-DPIC

CFLAGS.pic?=		${CFLAGS.pic.${CC_TYPE}:U}
CPPFLAGS.pic?=		${CPPFLAGS.pic.${CC_TYPE}:U}

####################
RANLIB.IRIX=		true

RANLIB?=		${RANLIB.${TARGET_OPSYS}:Uranlib}

####################
NROFF_MAN2CAT.SunOS?=		-man

NROFF_MAN2CAT?=			${NROFF_MAN2CAT.${OPSYS}:U-mandoc -Tascii}

####################
LD_TYPE.SunOS=			sunld
LD_TYPE.Darwin=			darwinld

LD_TYPE?=			${LD_TYPE.${TARGET_OPSYS}:Ugnuld}

####################
OBJECT_FMT?=			ELF

####################
LDFLAGS.shared.sunld?=		-G
LDFLAGS.soname.sunld?=		-h lib${LIB}.so.${SHLIB_MAJOR}

LDFLAGS.shared.darwinld?=	-dylib
LDFLAGS.soname.darwinld?=

LDFLAGS.shared.gnuld?=		-shared
LDFLAGS.soname.gnuld?=		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}


LDFLAGS.shared.gcc.Darwin?=	-dylib
LDFLAGS.shared.gcc?=		-shared
LDFLAGS.shared.pcc?=		-shared
LDFLAGS.shared.icc?=		-shared


LDFLAGS.soname.ld=		${LDFLAGS.soname.${LD_TYPE}:U}

.if defined(LDCOMPILER) && !empty(LDCOMPILER:M[Yy][Ye][Ss])
LDFLAGS.shared?=		${LDFLAGS.shared.${CC_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CC_TYPE}}:U-shared}
LDFLAGS.soname?=		${LDFLAGS.soname.ld:@v@-Wl,${v}@}
.else
LDFLAGS.shared?=		${LDFLAGS.shared.${LD_TYPE}:U-shared}
LDFLAGS.soname?=		${LDFLAGS.soname.ld}
.endif

############################################################
############################################################
.if ${OPSYS} == "Darwin"

COMPILE.s?=	${AS} ${AFLAGS}
COMPILE.S?=	${CC} ${AFLAGS} ${CPPFLAGS} -c

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3?=	.${SHLIB_FULLVERSION}.dylib
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL?=	.${SHLIB_FULLVERSION}.dylib

.endif # Darwin!

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
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL=	.so.${SHLIB_FULLVERSION}

.endif # SHLIB_EXT

.endif # defined(SHLIB_EXT)

############################################################
############################################################

.endif #_MKC_PLATFORM_MK
