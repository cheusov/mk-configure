# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef _MKC_PLATFORM_MK
_MKC_PLATFORM_MK=1

####################
SHLIB_EXT.Darwin=	.dylib
SHLIB_EXT.HP-UX=	.sl

SHLIB_EXT?=		${SHLIB_EXT.${TARGET_OPSYS}:U.so}

####################
BINMODE.Interix=	775
NONBINMODE.Interix=	664

BINMODE?=		${BINMODE.${TARGET_OPSYS}:U755}
NONBINMODE?=		${BINMODE.${TARGET_OPSYS}:U644}

SHLIBMODE.HP-UX=	${BINMODE}
SHLIBMODE.OSF1=		${BINMODE}
SHLIBMODE?=		${SHLIBMODE.${TARGET_OPSYS}:U${NONBINMODE}}

####################
ROOT_GROUP.NetBSD=		wheel
ROOT_GROUP.OpenBSD=		wheel
ROOT_GROUP.FreeBSD=		wheel
ROOT_GROUP.Darwin=		wheel
ROOT_GROUP.DragonFly=		wheel
ROOT_GROUP.MirBSD=		wheel
ROOT_GROUP.HP-UX=		bin
ROOT_GROUP.OSF1=		bin

ROOT_USER.HP-UX=		bin
ROOT_USER.OSF1=			bin

ROOT_USER?=		${ROOT_USER.${OPSYS}:Uroot}
ROOT_GROUP?=		${ROOT_GROUP.${OPSYS}:Uroot}

####################
INSTALL.NetBSD=		/usr/bin/install
INSTALL.OpenBSD=	/usr/bin/install
INSTALL.FreeBSD=	/usr/bin/install
INSTALL.DragonFly=	/usr/bin/install
INSTALL.MirBSD=		/usr/bin/install
INSTALL.Darwin=		/usr/bin/install
INSTALL.SunOS=		/usr/ucb/install
INSTALL.UnixWare=	/usr/ucb/install
INSTALL.HP-UX=		mkc_install
INSTALL.OSF1=		mkc_install
INSTALL.Interix=	mkc_install

.if ${OPSYS:Unone} == "Linux"
.if exists(/usr/bin/ginstall)
INSTALL?=		/usr/bin/ginstall
.elif exists(/bin/ginstall)
INSTALL?=		/bin/ginstall
.elif exists(/usr/bin/install)
INSTALL?=		/usr/bin/install
.elif exists(/bin/install)
INSTALL?=		/bin/install
.endif
.endif

INSTALL?=		${INSTALL.${TARGET_OPSYS}:Umkc_install}

# The following line is for debugging only
#INSTALL=		mkc_install

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

CC.OSF1=	gcc 
CXX.OSF1=	g++	
CPP.OSF1=	${CC} -E

CC.Interix=	gcc
CXX.Interix=	g++
CPP.Interix=	cpp

CC.QNX=		gcc
CXX.QNX=	g++
CPP.QNX=	${CC} -E

CXX.IRIX=	CC

CPP.AIX=	${CC} -E

CC?=		${CC.${TARGET_OPSYS}:Ucc}
CXX?=		${CXX.${TARGET_OPSYS}:Uc++}
CPP?=		${CPP.${TARGET_OPSYS}:Ucpp}

####################
CPPFLAGS.Interix=	-D_ALL_SOURCE
CPPFLAGS.UnixWare=	-DUNIXWARE

CPPFLAGS+=	${CPPFLAGS.${TARGET_OPSYS}:U}

############################################################
# CC compiler type
.if make(cleandir) || make(distclean) || make(clean)
DISTCLEANFILES+=	_mkc_compiler_type.res
.elif !defined(SKIP_CONFIGURE_MK) && !defined(CC_TYPE) && (defined(PROG) || defined(LIB))
mkc.cc_type.environ= CC='${CC}' CXX='${CXX}' CPPFLAGS='${CPPFLAGS}' CFLAGS='${CFLAGS}' LDFLAGS='${LDFLAGS}' LDADD='${LDADD}' MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1
.if !empty(src_type:Mc)
CC_TYPE!=	env ${mkc.cc_type.environ} mkc_check_compiler
.elif !empty(src_type:Mcxx)
CXX_TYPE!=	env ${mkc.cc_type.environ} mkc_check_compiler -x
.endif # src_type
.endif # cleandir|distclean|...

CC_TYPE?=	unknown
CXX_TYPE?=	unknown

####################
# C warns (gcc)
CFLAGS.warns.gcc.1=		-Wall -Wstrict-prototypes -Wmissing-prototypes \
				-Wpointer-arith
CFLAGS.warns.gcc.2=		${CFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
CFLAGS.warns.gcc.3=		${CFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wextra -Wno-unused-parameter
CFLAGS.warns.gcc.4=		${CFLAGS.warns.gcc.3}

CFLAGS+=			${CFLAGS.warns.${CC_TYPE}.${WARNS}}

# C++ warns (gcc)
CXXFLAGS.warns.gcc.1=		-Wabi -Wold-style-cast -Wctor-dtor-privacy \
				-Wnon-virtual-dtor -Wreorder -Wno-deprecated \
				-Wno-non-template-friend -Woverloaded-virtual \
				-Wno-pmf-conversions -Wsign-promo -Wsynth
CXXFLAGS.warns.gcc.2=		${CXXFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
CXXFLAGS.warns.gcc.3=		${CXXFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wextra -Wno-unused-parameter
CXXFLAGS.warns.gcc.4=		${CXXFLAGS.warns.gcc.3}

CXXFLAGS+=			${CXXFLAGS.warns.${CXX_TYPE}.${WARNS}}

####################

#FFLAGS.pic?= -fPIC

####################
CFLAGS.pic.gcc.Interix=		-DPIC
CPPFLAGS.pic.gcc.Interix=	-DPIC

CFLAGS.pic.gcc=		-fPIC -DPIC
CPPFLAGS.pic.gcc=	-DPIC

CFLAGS.pic.icc=		-fPIC -DPIC
CPPFLAGS.pic.icc=	-DPIC

CFLAGS.pic.pcc=		-k
CPPFLAGS.pic.pcc=

CFLAGS.pic.mipspro=	-KPIC
CPPFLAGS.pic.mipspro=

CFLAGS.pic.sunpro=	-KPIC # -xcode=pic32
CPPFLAGS.pic.sunpro=

CFLAGS.pic.hpc=		+Z # +z
CPPFLAGS.pic.hpc=

CFLAGS.pic.ibmc=	-qpic=large # -qpic=small
CPPFLAGS.pic.ibmc=

CFLAGS.pic.decc=	# ?
CPPFLAGS.pic.decc=	# ?

CFLAGS.pic?=	  ${CFLAGS.pic.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pic.${CC_TYPE}:U}}
CXXFLAGS.pic?=	 ${CFLAGS.pic.${CXX_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pic.${CXX_TYPE}:U}}
CPPFLAGS.pic?=	${CPPFLAGS.pic.${CC_TYPE}.${TARGET_OPSYS}:U${CPPFLAGS.pic.${CC_TYPE}:U}}

####################
RANLIB.IRIX=		true

RANLIB?=		${RANLIB.${TARGET_OPSYS}:Uranlib}

####################
NROFF_MAN2CAT.SunOS?=		-man
NROFF_MAN2CAT.HP-UX?=		-man
NROFF_MAN2CAT.OSF1?=		-man

NROFF_MAN2CAT?=			${NROFF_MAN2CAT.${OPSYS}:U-mandoc -Tascii}

####################
LD_TYPE.UnixWare=		scold
LD_TYPE.AIX=			aixld
LD_TYPE.HP-UX=			hpld
LD_TYPE.SunOS=			sunld
LD_TYPE.Darwin=			darwinld
LD_TYPE.Interix=		interixld
LD_TYPE.OSF1=			osf1ld

LD_TYPE?=			${LD_TYPE.${TARGET_OPSYS}:Ugnuld}

####################
OBJECT_FMT?=			ELF

####################
LDFLAGS.shared.sunld=		-G
LDFLAGS.soname.sunld=		-h lib${LIB}.so.${SHLIB_MAJOR}

LDFLAGS.shared.darwinld=	-dylib
LDFLAGS.soname.darwinld=	#

LDFLAGS.shared.gnuld=		-shared
LDFLAGS.soname.gnuld=		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}

LDFLAGS.shared.hpld=		-b +b ${LIBDIR}
LDFLAGS.soname.hpld=		+h lib${LIB}.sl.${SHLIB_MAJOR}

LDFLAGS.shared.aixld=		-G
LDFLAGS.soname.aixld=		#

LDFLAGS.shared.irixld=		-shared
LDFLAGS.soname.irixld=		#

LDFLAGS.shared.osf1ld=		-shared
LDFLAGS.soname.osf1ld=		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}

LDFLAGS.shared.interixld=	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
LDFLAGS.soname.interixld=	-h lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}


LDFLAGS.shared.gcc.Darwin=	-dynamiclib -install_name ${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
LDFLAGS.shared.gcc.Interix=	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
LDFLAGS.shared.gcc=		-shared
LDFLAGS.shared.pcc=		-shared
LDFLAGS.shared.icc=		-shared
LDFLAGS.shared.hpc=		-b
LDFLAGS.shared.imbc=		-qmkshrobj
LDFLAGS.shared.mipspro=		-shared
LDFLAGS.shared.sunpro=		-G
LDFLAGS.shared.decc=		-shared

.if ${TARGET_OPSYS:Unone} == "Darwin"
SHLIB_MAJORp1!=			expr 1 + ${SHLIB_MAJOR:U0}
LDFLAGS.soname.gcc=		-current_version ${SHLIB_MAJORp1}${SHLIB_MINOR:D.${SHLIB_MINOR}}${SHLIB_TEENY:D.${SHLIB_TEENY}}
LDFLAGS.soname.gcc+=		-compatibility_version ${SHLIB_MAJORp1}
.endif

#CFLAGS.cctold.gcc=		-Wl,

CFLAGS.cctold?=			${CFLAGS.cctold.${CC_TYPE}:U-Wl,}
CXXFLAGS.cctold?=		${CFLAGS.cctold.${CXX_TYPE}:U-Wl,}

LDFLAGS.soname.ld=		${LDFLAGS.soname.${LD_TYPE}:U}

.if ${LDREAL:U0} == ${LD:U0}
LDFLAGS.shared?=		${LDFLAGS.shared.${LD_TYPE}:U-shared}
LDFLAGS.soname?=		${LDFLAGS.soname.ld}
.elif ${LDREAL:U0} == ${CC:U0}
LDFLAGS.shared?=		${LDFLAGS.shared.${CC_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CC_TYPE}:U-shared}}
LDFLAGS.soname?=		${LDFLAGS.soname.${CC_TYPE}:U${LDFLAGS.soname.ld:@v@${CFLAGS.cctold}${v}@}}
.elif ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.shared?=		${LDFLAGS.shared.${CXX_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CXX_TYPE}:U-shared}}
LDFLAGS.soname?=		${LDFLAGS.soname.${CXX_TYPE}:U${LDFLAGS.soname.ld:@v@${CXXFLAGS.cctold}${v}@}}
.endif

############################################################
############################################################
.if ${TARGET_OPSYS:Unone} == "Darwin"

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

.if ${SHLIB_EXT} == ".so" || ${SHLIB_EXT} == ".sl"

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1=	${SHLIB_EXT}.${SHLIB_MAJOR}
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2=	${SHLIB_EXT}.${SHLIB_MAJOR}.${SHLIB_MINOR}
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
SHLIB_EXT3=	${SHLIB_EXT}.${SHLIB_FULLVERSION}
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION=${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL=	${SHLIB_EXT}.${SHLIB_FULLVERSION}

.endif # SHLIB_EXT

.endif # defined(SHLIB_EXT)

############################################################
############################################################

.endif #_MKC_PLATFORM_MK
