# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_PLATFORM_MK
_MKC_PLATFORM_MK := 1

####################
# cross tools
.ifdef SYSROOT
CFLAGS.sysroot  ?=	--sysroot=${SYSROOT}
LDFLAGS.sysroot ?=	--sysroot=${SYSROOT}
CFLAGS   +=	${CFLAGS.sysroot}
LDFLAGS0 +=	${LDFLAGS.sysroot}

TOOLCHAIN_PREFIX ?=	${MACHINE_GNU_PLATFORM}-
TOOLCHAIN_DIR    ?=	${TOOLDIR}/bin

NM        =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}nm
#ADDR2LINE =    ${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}addr2line
AR        =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}ar
AS        =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}as
CXX       =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}g++
CPP       =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}cpp
CC        =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}gcc
INSTALL   =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}install
LD        =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}ld
OBJCOPY   =    ${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objcopy
OBJDUMP   =    ${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objdump
RANLIB    =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}ranlib
#READELF   =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}readelf
SIZE      =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}size
#STRINGS   =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}strings
STRIP     =	${TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}strip
.endif

####################
SHLIB_EXT.Darwin =	.dylib
SHLIB_EXT.HP-UX  =	.sl

SHLIB_EXT       ?=	${SHLIB_EXT.${TARGET_OPSYS}:U.so}

DLL_EXT.Darwin  =	.bundle
DLL_EXT        ?=	${DLL_EXT.${TARGET_OPSYS}:U${SHLIB_EXT}}

####################
INSTALL.NetBSD    =	/usr/bin/install
INSTALL.OpenBSD   =	/usr/bin/install
INSTALL.FreeBSD   =	/usr/bin/install
INSTALL.DragonFly =	/usr/bin/install
INSTALL.MirBSD    =	/usr/bin/install
INSTALL.Haiku     =	/bin/install

INSTALL  ?=		${INSTALL.${TARGET_OPSYS}:Umkc_install}

# The following line is for debugging only
#INSTALL=		mkc_install

####################

CC.SunOS  =	cc
CXX.SunOS =	CC

CPP.SunOS    =	${CC} -E

CC.UnixWare  =	gcc
CXX.UnixWare =	g++
CPP.UnixWare =	${CC} -E

CC.OSF1  =	gcc 
CXX.OSF1 =	g++	
CPP.OSF1 =	${CC} -E

CC.Interix  =	gcc
CXX.Interix =	g++
CPP.Interix =	cpp

CC.IRIX64  =	cc
CXX.IRIX64 =	CC
CPP.IRIX64 =	${CC} -E

CC.QNX  =	gcc
CXX.QNX =	g++
CPP.QNX =	${CC} -E

CPP.AIX =	${CC} -E

CC  ?=		${CC.${TARGET_OPSYS}:Ucc}
CXX ?=		${CXX.${TARGET_OPSYS}:Uc++}
CPP ?=		${CPP.${TARGET_OPSYS}:Ucpp}

####################
CPPFLAGS.Interix  =	-D_ALL_SOURCE
CPPFLAGS.UnixWare =	-DUNIXWARE

CPPFLAGS +=	${CPPFLAGS.${TARGET_OPSYS}:U}

############################################################
# CC compiler type
.if make(cleandir) || make(distclean) || make(clean)
.elif ${MKCHECKS:Uno:tl} == "yes" && !defined(CC_TYPE) && (defined(PROGS) || defined(LIB) || defined(MKC_CHECK_PROTOTYPES))
mkc.cc_type.environ = CC='${CC}' CXX='${CXX}' CPPFLAGS='${CPPFLAGS}' CFLAGS='${CFLAGS}' LDFLAGS='${LDFLAGS}' LDADD='${LDADD}' MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1
.if !empty(src_type:Mc)
CC_TYPE  !=	env ${mkc.cc_type.environ} mkc_check_compiler
.endif
.if !empty(src_type:Mcxx)
CXX_TYPE !=	env ${mkc.cc_type.environ} mkc_check_compiler -x
.endif # src_type
.endif # cleandir|distclean|...

CC_TYPE  ?=	unknown
CXX_TYPE ?=	unknown

####################
# Default compiler-specific options

# C
CFLAGS.dflt.clang     =		-Qunused-arguments -Werror=implicit-function-declaration
CFLAGS.dflt.icc       =		-we147 # 147 is required for MKC_CHECK_PROTOTYPES

CFLAGS               +=		${CFLAGS.dflt.${CC_TYPE}}

# C++
CXXFLAGS.dflt.clang   =		${CFLAGS.dflt.clang}
CXXFLAGS.dflt.icc     =		${CFLAGS.dflt.icc}

CXXFLAGS             +=		${CXXFLAGS.dflt.${CXX_TYPE}}

####################
# Warnings as error
CFLAGS.warnerr.gcc    =		-Werror
CFLAGS.warnerr.icc    =		-Werror
CFLAGS.warnerr.sunpro =		-errwarn=%all
CFLAGS.warnerr.clang  =		-Werror

WARNERR  ?=	${WARNS:U0:S/4/yes/}

CFLAGS.warnerr   =	${${WARNERR:tl} == "yes":?${CFLAGS.warnerr.${CC_TYPE}}:}
CXXFLAGS.warnerr =	${${WARNERR:tl} == "yes":?${CFLAGS.warnerr.${CXX_TYPE}}:}

####################
# C warns for GCC
CFLAGS.warns.gcc.1 =		-Wall -Wstrict-prototypes -Wmissing-prototypes \
				-Wpointer-arith
CFLAGS.warns.gcc.2 =		${CFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
CFLAGS.warns.gcc.3 =		${CFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wno-unused-parameter
CFLAGS.warns.gcc.4 =		${CFLAGS.warns.gcc.3}

# C++ warns
CXXFLAGS.warns.gcc.1 =		-Wabi -Wold-style-cast -Wctor-dtor-privacy \
				-Wnon-virtual-dtor -Wreorder -Wno-deprecated \
				-Wno-non-template-friend -Woverloaded-virtual \
				-Wno-pmf-conversions -Wsign-promo -Wsynth
CXXFLAGS.warns.gcc.2 =		${CXXFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
CXXFLAGS.warns.gcc.3 =		${CXXFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wno-unused-parameter
CXXFLAGS.warns.gcc.4 =		${CXXFLAGS.warns.gcc.3}

####################
# C warns for ICC
CFLAGS.warns.icc.1 =		-Wall -we1011
CFLAGS.warns.icc.2 =		${CFLAGS.warns.icc.1}
CFLAGS.warns.icc.3 =		${CFLAGS.warns.icc.2}
CFLAGS.warns.icc.4 =		${CFLAGS.warns.icc.3}

# C++ warns
CXXFLAGS.warns.icc.1 =		${CFLAGS.warns.icc.1}
CXXFLAGS.warns.icc.2 =		${CFLAGS.warns.icc.2}
CXXFLAGS.warns.icc.3 =		${CFLAGS.warns.icc.3}
CXXFLAGS.warns.icc.4 =		${CFLAGS.warns.icc.4}

####################
# C warns for clang
CFLAGS.warns.clang.1 =		-Wall
CFLAGS.warns.clang.2 =		${CFLAGS.warns.clang.1}
CFLAGS.warns.clang.3 =		${CFLAGS.warns.clang.2}
CFLAGS.warns.clang.4 =		${CFLAGS.warns.clang.3}

CXXFLAGS.warns.clang.1 =	${CFLAGS.warns.clang.1}
CXXFLAGS.warns.clang.2 =	${CFLAGS.warns.clang.2}
CXXFLAGS.warns.clang.3 =	${CFLAGS.warns.clang.3}
CXXFLAGS.warns.clang.4 =	${CFLAGS.warns.clang.4}

####################
# C warns for HP-UX
CFLAGS.warns.hpc.0 =		-w3
CFLAGS.warns.hpc.1 =		-w2
CFLAGS.warns.hpc.2 =		-w2
CFLAGS.warns.hpc.3 =		-w2
CFLAGS.warns.hpc.4 =		-w2

# C++ warns
CXXFLAGS.warns.hpc.0 =		${CFLAGS.warns.hpc.0}
CXXFLAGS.warns.hpc.1 =		${CFLAGS.warns.hpc.1}
CXXFLAGS.warns.hpc.2 =		${CFLAGS.warns.hpc.2}
CXXFLAGS.warns.hpc.3 =		${CFLAGS.warns.hpc.3}
CXXFLAGS.warns.hpc.4 =		${CFLAGS.warns.hpc.4}

####################

CFLAGS.warns   =		${CFLAGS.warns.${CC_TYPE}.${WARNS}}    ${CFLAGS.warnerr}
CXXFLAGS.warns =		${CXXFLAGS.warns.${CXX_TYPE}.${WARNS}} ${CXXFLAGS.warnerr}

####################
CFLAGS.pic.gcc.Interix =
CFLAGS.pic.gcc =		-fPIC -DPIC
CFLAGS.pic.icc =		-fPIC -DPIC
CFLAGS.pic.clang =		-fPIC -DPIC
CFLAGS.pic.pcc =		-k -DPIC
CFLAGS.pic.mipspro =		-KPIC
CFLAGS.pic.sunpro =		-xcode=pic32 # -KPIC
CFLAGS.pic.hpc =		+Z # +z
CFLAGS.pic.ibmc =		-qpic=large # -qpic=small
CFLAGS.pic.decc =		# ?

CFLAGS.pic   ?=	${CFLAGS.pic.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pic.${CC_TYPE}:U}}
CXXFLAGS.pic ?=	${CFLAGS.pic.${CXX_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pic.${CXX_TYPE}:U}}

####################
CFLAGS.pie.gcc.Interix =
CFLAGS.pie.gcc =		-fPIE -DPIC
CFLAGS.pie.icc =		-fPIE -DPIC
CFLAGS.pie.clang =		-fPIE -DPIC

CFLAGS.pie   ?=	${CFLAGS.pie.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pie.${CC_TYPE}}:U${CFLAGS.pic}}
CXXFLAGS.pie ?=	${CFLAGS.pie.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pie.${CXX_TYPE}}:U${CXXFLAGS.pic}}

####################
CFLAGS.ssp.gcc =		-fstack-protector -Wstack-protector --param ssp-buffer-size=1
CFLAGS.ssp.icc =		-fstack-security-check
CFLAGS.ssp.ibmc =		-qstackprotect
CFLAGS.ssp.clang =		${CFLAGS.ssp.gcc}

CFLAGS.ssp   ?=	${CFLAGS.ssp.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.ssp.${CC_TYPE}:U}}
CXXFLAGS.ssp ?=	${CFLAGS.ssp.${CXX_TYPE}.${TARGET_OPSYS}:U${CFLAGS.ssp.${CXX_TYPE}:U}}

####################
RANLIB.IRIX64 =		true

RANLIB ?=		${RANLIB.${TARGET_OPSYS}:Uranlib}

####################
NROFF_MAN2CAT.SunOS ?=		-man
NROFF_MAN2CAT.HP-UX ?=		-man
NROFF_MAN2CAT.OSF1  ?=		-man

NROFF_MAN2CAT ?=		${NROFF_MAN2CAT.${OPSYS}:U-mandoc -Tascii}

####################
LD_TYPE.UnixWare =		scold
LD_TYPE.AIX      =		aixld
LD_TYPE.HP-UX    =		hpld
LD_TYPE.SunOS    =		sunld
LD_TYPE.Darwin   =		darwinld
LD_TYPE.Interix  =		interixld
LD_TYPE.OSF1     =		osf1ld
LD_TYPE.IRIX64   =		irixld

LD_TYPE  ?=			${LD_TYPE.${TARGET_OPSYS}:Ugnuld}

####################
OBJECT_FMT ?=			ELF

####################
LDFLAGS.shared.sunld =		-G
LDFLAGS.soname.sunld =		-h lib${LIB}.so.${SHLIB_MAJOR}

LDFLAGS.shared.darwinld =	-dylib
LDFLAGS.soname.darwinld =	#

LDFLAGS.shared.gnuld =		-shared
LDFLAGS.soname.gnuld =		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}

LDFLAGS.shared.hpld =		-b +b ${LIBDIR}
LDFLAGS.soname.hpld =		+h lib${LIB}.sl.${SHLIB_MAJOR}

LDFLAGS.shared.aixld =		-G
LDFLAGS.soname.aixld =		#

LDFLAGS.shared.irixld =		-shared
LDFLAGS.soname.irixld =		#

LDFLAGS.shared.osf1ld =		-shared -msym -expect_unresolved '*'
LDFLAGS.soname.osf1ld =		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR} \
				-set_version ${SHLIB_MAJOR}.${SHLIB_MINOR} \
				-update_registry ${.OBJDIR}/${LIB}_so_locations

LDFLAGS.shared.irixld =		-shared
LDFLAGS.soname.irixld =		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}

LDFLAGS.shared.interixld =	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
LDFLAGS.soname.interixld =	-h lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}

LDFLAGS.shared.gcc.Interix =	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
LDFLAGS.shared.gcc   =		-shared
LDFLAGS.shared.clang =		-shared
LDFLAGS.shared.pcc   =		-shared
LDFLAGS.shared.icc   =		-shared
LDFLAGS.shared.hpc   =		-b
LDFLAGS.shared.imbc  =		-qmkshrobj
LDFLAGS.shared.mipspro =	-shared
LDFLAGS.shared.sunpro  =	-G
LDFLAGS.shared.decc    =	-shared

LDFLAGS.soname.sunpro  =	${LDFLAGS.soname.sunld}

.if ${TARGET_OPSYS:Unone} == "Darwin"
.if ${MKDLL:U} == "no"
LDFLAGS.shared.gcc.Darwin  =	-dynamiclib -install_name ${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
LDFLAGS.shared.clang.Darwin  =	-dynamiclib -install_name ${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
SHLIB_MAJORp1 !=		expr 1 + ${SHLIB_MAJOR:U0}
LDFLAGS.soname.gcc =		-current_version ${SHLIB_MAJORp1}${SHLIB_MINOR:D.${SHLIB_MINOR}}${SHLIB_TEENY:D.${SHLIB_TEENY}}
LDFLAGS.soname.gcc +=		-compatibility_version ${SHLIB_MAJORp1}
.else
LDFLAGS.shared.gcc.Darwin =	-flat_namespace -bundle -undefined suppress
LDFLAGS.shared.clang.Darwin =	-flat_namespace -bundle -undefined suppress
.endif
.elif ${TARGET_OPSYS:Unone} == "OSF1" && defined(LIB)
CLEANFILES +=			${.OBJDIR}/${LIB}_so_locations
.endif

CFLAGS.cctold   ?=		${CFLAGS.cctold.${CC_TYPE}:U-Wl,}
CXXFLAGS.cctold ?=		${CFLAGS.cctold.${CXX_TYPE}:U-Wl,}

LDFLAGS.soname.ld =		${LDFLAGS.soname.${LD_TYPE}:U}

.if ${LDREAL:U0} == ${LD:U0}
LDFLAGS.shared ?=		${LDFLAGS.shared.${LD_TYPE}:U-shared}
LDFLAGS.soname ?=		${LDFLAGS.soname.ld}
.elif ${LDREAL:U0} == ${CC:U0}
LDFLAGS.shared ?=		${LDFLAGS.shared.${CC_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CC_TYPE}:U-shared}}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CC_TYPE}:U${LDFLAGS.soname.ld:@v@${CFLAGS.cctold}${v}@}}
.elif ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.shared ?=		${LDFLAGS.shared.${CXX_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CXX_TYPE}:U-shared}}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CXX_TYPE}:U${LDFLAGS.soname.ld:@v@${CXXFLAGS.cctold}${v}@}}
.endif

####################
LDFLAGS.pie.gcc =		-pie

.if ${LDREAL:U0} == ${CC:U0}
LDFLAGS.pie ?=			${LDFLAGS.pie.${CC_TYPE}}
.elif ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.pie ?=			${LDFLAGS.pie.${CXX_TYPE}}
.endif
####################
LDFLAGS.relro.gnuld =		-zrelro -znow

LDFLAGS.relro ?=		${LDFLAGS.relro.${LD_TYPE}}

####################
.if ${LDREAL:U0} != ${LD:U0}
.if !empty(LDFLAGS.relro)
LDFLAGS.relro := ${LDFLAGS.relro:S/^/-Wl,/g}
.endif
.endif

############################################################
############################################################
.if ${TARGET_OPSYS:Unone} == "Darwin"

COMPILE.s  ?=	${AS} ${AFLAGS}
COMPILE.S  ?=	${CC} ${AFLAGS} ${_CPPFLAGS} -c

.if ${MKDLL:U} != "no"

SHLIB_EXTFULL  ?=	.bundle

.else # MKDLL

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1 ?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2 ?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3 ?=	.${SHLIB_FULLVERSION}.dylib
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL ?=	.${SHLIB_FULLVERSION}.dylib
.endif

.endif # Darwin!

############################################################
############################################################

.if ${SHLIB_EXT:U} == ".so" || ${SHLIB_EXT:U} == ".sl"

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1 =	${SHLIB_EXT}.${SHLIB_MAJOR}
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2 =	${SHLIB_EXT}.${SHLIB_MAJOR}.${SHLIB_MINOR}
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
SHLIB_EXT3 =	${SHLIB_EXT}.${SHLIB_FULLVERSION}
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL =	${SHLIB_EXT}.${SHLIB_FULLVERSION}

.endif # SHLIB_EXT

############################################################
############################################################

.ifdef EXPORT_SYMBOLS
.if ${LD_TYPE} == "sunld" || ${LD_TYPE} == "gnuld"
CLEANFILES +=	${EXPORT_SYMBOLS}.tmp
lib${LIB}${SHLIB_EXTFULL}: ${EXPORT_SYMBOLS}.tmp
${EXPORT_SYMBOLS}.tmp:	${EXPORT_SYMBOLS}
	awk 'BEGIN {print "{ global:"} \
	     {print $$0 ";"} \
	     END {print "local: *; };"}' ${.ALLSRC} > ${.TARGET}
.elif ${LD_TYPE} == "darwinld"
CLEANFILES +=	${EXPORT_SYMBOLS}.tmp
lib${LIB}${SHLIB_EXTFULL}: ${EXPORT_SYMBOLS}.tmp
${EXPORT_SYMBOLS}.tmp:	${EXPORT_SYMBOLS}
	awk '{print "_" $$0}' ${.ALLSRC} > ${.TARGET}
.endif # sunld or darwinld

LDFLAGS.expsym.gnuld    =	--version-script ${EXPORT_SYMBOLS}.tmp
LDFLAGS.expsym.sunld    =	-M ${EXPORT_SYMBOLS}.tmp
LDFLAGS.expsym.darwinld =	-exported_symbols_list ${EXPORT_SYMBOLS}.tmp
.endif # EXPORT_SYMBOLS

.if ${LDREAL:U0} == ${LD:U0}
LDFLAGS.expsym ?=		${LDFLAGS.expsym.${LD_TYPE}}
.elif defined(LDFLAGS.expsym.${LD_TYPE})
LDFLAGS.expsym ?=		${LDFLAGS.expsym.${LD_TYPE}:S/^/-Wl,/}
.endif # LDREAL == LD

############################################################
############################################################

.if ${EXPORT_DYNAMIC:U:tl} == "yes"
LDFLAGS.expdyn.gnuld     ?=	-Wl,-E
LDFLAGS.expdyn.hpld      ?=	-Wl,-E
LDFLAGS.expdyn.interixld ?=	-Wl,-E
LDFLAGS.expdyn.darwinld  ?=
LDFLAGS.expdyn.irixld    ?=
LDFLAGS.expdyn.gcc       ?=	-rdynamic
LDFLAGS.expdyn.clang     ?=	-rdynamic
.ifndef LDFLAGS.expdyn
.if defined(LDFLAGS.expdyn.${LD_TYPE})
LDFLAGS.expdyn =	${LDFLAGS.expdyn.${LD_TYPE}}
.elif defined(LDFLAGS.expdyn.${CC_TYPE}) && ${LDREAL:U0} == ${CC:U0}
LDFLAGS.expdyn =	${LDFLAGS.expdyn.${CC_TYPE}}
.elif defined(LDFLAGS.expdyn.${CXX_TYPE}) && ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.expdyn =	${LDFLAGS.expdyn.${CXX_TYPE}}
.endif # LDFLAGS.expdyn.xxx
.endif # LDFLAGS.expdyn
.endif # EXPORT_DYNAMIC

############################################################
############################################################

LDFLAGS.shlib =	${LDFLAGS.shared} ${LDFLAGS.soname} ${LDFLAGS.expsym}
LDFLAGS.prog  =	${LDFLAGS.expdyn}
############################################################
############################################################

.endif #_MKC_PLATFORM_MK
