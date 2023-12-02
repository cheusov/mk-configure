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

.ifdef MK_C_PROJECT
_MKFILESDIR         =	${MK_C_PROJECT}/mk
.else
_MKFILESDIR         =	${MKFILESDIR}
.endif

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
.sinclude "mkc_imp.platform.${OPSYS}.mk"

####################

SHLIB_EXT       ?=	${SHLIB_EXT.${TARGET_OPSYS}:U.so}
DLL_EXT        ?=	${DLL_EXT.${TARGET_OPSYS}:U${SHLIB_EXT}}

CC  ?=		${CC.${TARGET_OPSYS}:Ucc}
CXX ?=		${CXX.${TARGET_OPSYS}:Uc++}
CPP ?=		${CPP.${TARGET_OPSYS}:U${CC} -E}

CPPFLAGS +=	${CPPFLAGS.${TARGET_OPSYS}:U}

############################################################
# CC compiler type
.if ${MKCHECKS} == "no"
.elif ${MKCHECKS:Uno:tl} == "yes"
mkc.cc_type.environ = CC=${CC:Q} CXX=${CXX:Q} CPPFLAGS=${CPPFLAGS:Q} CFLAGS=${CFLAGS:Q} LDFLAGS=${LDFLAGS:Q} LDADD=${LDADD:Q} MKC_CACHEDIR=${MKC_CACHEDIR:Q} MKC_DELETE_TMPFILES=${MKC_DELETE_TMPFILES:Q} MKC_SHOW_CACHED=${MKC_SHOW_CACHED:Q} MKC_NOCACHE=${MKC_NOCACHE:Q} MKC_VERBOSE=1
.   for c in ${src_type}
_full_type         !=	env ${mkc.cc_type.environ} mkc_check_compiler ${"${c}" == "cxx":?-x:}
${c:tu}_TYPE       :=	${_full_type:[1]}
${c:tu}_VERSION    :=	${_full_type:[2]}
${c:tu}_TRIPLET    :=	${_full_type:[3]}
.if !empty(${c:tu}_TRIPLET)
${c:tu}_TRIPLET    :=	-${${c:tu}_TRIPLET}
.endif
.       undef _full_type
_mkfile:=mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET}.mk
.       if ${MKCOMPILERSETTINGS:Uno:tl} == "force"
.       elif exists(${_MKFILESDIR}/${_mkfile})
            _full_mkfile:=${_MKFILESDIR}/${_mkfile}
.       elif exists(${HOME}/.mk-c/${_mkfile})
.           warning "Directory ~/.mk-c is deprecated since 2020-12-11, please rename it to ~/.mkcmake"
            _full_mkfile:=${HOME}/.mk-c/${_mkfile}
.       elif exists(${HOME}/.mkcmake/${_mkfile})
            _full_mkfile:=${HOME}/.mkcmake/${_mkfile}
.       endif
.       if defined(_full_mkfile)
            _ != test ${_full_mkfile} -ot ${.PARSEDIR}/${.PARSEFILE}; echo $$?
.           if ${_} == 0 && !defined(MK_C_PROJECT) && !defined(compiler_settings)
.               if ${MKCOMPILERSETTINGS:Uno:tl} == "yes"
_ != env CC= CXX= ${c:tu}=${${c:tu}} mkc_compiler_settings
.                   include "${HOME}/.mkcmake/${_mkfile}"
.               else
.                   error '${_full_mkfile} is older than ${.PARSEDIR}/${.PARSEFILE}, please update it using "mkc_compiler_settings" utility'
.               endif
.           endif
.           undef _
.           if !defined(compiler_settings)
.               include "${_full_mkfile}"
.           endif
.       elif !defined(MK_C_PROJECT) && empty(compiler_settings)
.           if ${MKCOMPILERSETTINGS:Uno:tl} == "yes" || ${MKCOMPILERSETTINGS:Uno:tl} == "force"
_ != env CC= CXX= ${c:tu}=${${c:tu}} mkc_compiler_settings
.               include "${HOME}/.mkcmake/${_mkfile}"
.           else
.               error 'Settings for ${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET} is not available, run "mkc_compiler_settings" utility'
.           endif
.       endif # exists(...)

.       undef _full_mkfile
.       undef _mkfile
.   endfor # .for c in ${src_type}
.endif # cleandir|distclean|...

CC_TYPE  ?=	unknown
CXX_TYPE ?=	unknown

CC_VERSION  ?=	0
CXX_VERSION ?=	0

# C/C++ default flags
CFLAGS      +=		${CFLAGS.dflt.${CC_TYPE}}
CXXFLAGS    +=		${CXXFLAGS.dflt.${CXX_TYPE}}

####################
# Warnings as error

WARNERR     ?=		${WARNS:U0:S/4/yes/}

CFLAGS.warnerr   =	${${WARNERR:tl} == "yes":?${CFLAGS.warnerr.${CC_TYPE}}:}
CXXFLAGS.warnerr =	${${WARNERR:tl} == "yes":?${CXXFLAGS.warnerr.${CXX_TYPE}}:}

CFLAGS.warns     =	${CFLAGS.warns.${CC_TYPE}.${WARNS}}    ${CFLAGS.warnerr}
CXXFLAGS.warns   =	${CXXFLAGS.warns.${CXX_TYPE}.${WARNS}} ${CXXFLAGS.warnerr}

CFLAGS.pic      ?=	${CFLAGS.pic.${CC_TYPE}:U}
CXXFLAGS.pic    ?=	${CXXFLAGS.pic.${CXX_TYPE}:U}

NROFF_MAN2CAT ?=		${NROFF_MAN2CAT.${OPSYS}:U-mandoc -Tascii}

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

CFLAGS.cctold   ?=		-Wl,
CXXFLAGS.cctold ?=		-Wl,

LDFLAGS.soname.ld =		${LDFLAGS.soname.${LD_TYPE}:U}

.if ${LDREAL:U0} == ${CC:U0}
LDFLAGS.shared ?=		${LDFLAGS.shared.${CC_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CC_TYPE}:U-shared}}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CC_TYPE}:U${LDFLAGS.soname.ld:@v@${CFLAGS.cctold}${v}@}}
.elif ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.shared ?=		${LDFLAGS.shared.${CXX_TYPE}.${TARGET_OPSYS}:U${LDFLAGS.shared.${CXX_TYPE}:U-shared}}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CXX_TYPE}:U${LDFLAGS.soname.ld:@v@${CXXFLAGS.cctold}${v}@}}
.endif

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
	     {sub(/#.*/, ""); if (NF>0) { $$1=$$1; print $$0 ";"} } \
	     END {print "local: *; };"}' ${.ALLSRC} > ${.TARGET}
.elif ${LD_TYPE} == "darwinld"
CLEANFILES +=	${EXPORT_SYMBOLS}.tmp
lib${LIB}${SHLIB_EXTFULL}: ${EXPORT_SYMBOLS}.tmp
${EXPORT_SYMBOLS}.tmp:	${EXPORT_SYMBOLS}
	awk '{sub(/#.*/, ""); if (NF>0) { $$1=$$1; print "_" $$0}}' ${.ALLSRC} > ${.TARGET}
.endif # sunld or darwinld

LDFLAGS.expsym.gnuld    =	--version-script ${EXPORT_SYMBOLS}.tmp
LDFLAGS.expsym.sunld    =	-M ${EXPORT_SYMBOLS}.tmp
LDFLAGS.expsym.darwinld =	-exported_symbols_list ${EXPORT_SYMBOLS}.tmp
.endif # EXPORT_SYMBOLS

.if defined(LDFLAGS.expsym.${LD_TYPE})
LDFLAGS.expsym ?=		${LDFLAGS.expsym.${LD_TYPE}:S/^/-Wl,/}
.endif

############################################################
############################################################

LDFLAGS.shlib =	${LDFLAGS.shared} ${LDFLAGS.soname} ${LDFLAGS.expsym}
LDFLAGS.prog  =	${LDFLAGS.expdyn}
############################################################
############################################################

.endif #_MKC_PLATFORM_MK
