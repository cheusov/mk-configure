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
.include "mkc_imp.cross_compiling.mk"
.endif

####################

SHLIB_EXT       ?=	${SHLIB_EXT.${TARGET_OPSYS}:U.so}
DLL_EXT        ?=	${DLL_EXT.${TARGET_OPSYS}:U${SHLIB_EXT}}

CC  ?=		${CC.${TARGET_OPSYS}:Ucc}
CXX ?=		${CXX.${TARGET_OPSYS}:Uc++}
CPP ?=		${CPP.${TARGET_OPSYS}:U${CC} -E}

CPPFLAGS +=	${CPPFLAGS.${TARGET_OPSYS}:U}

############################################################
# CC compiler type
.if ${MKCHECKS:Uno:tl} == "yes"
.include "mkc_imp.compiler_config.mk"
.endif # MKCHECKS == yes

####################
.sinclude "mkc_imp.platform.${OPSYS}.mk"

####################
CC_TYPE  ?=	unknown
CXX_TYPE ?=	unknown

CC_VERSION  ?=	0
CXX_VERSION ?=	0

# C/C++ default flags
CFLAGS      +=		${CFLAGS.dflt}
CXXFLAGS    +=		${CXXFLAGS.dflt}

####################
# Warnings as error

WARNERR     ?=		${${WARNS:U0} == 4:?yes:}

_CFLAGS.warnerr  =	${${WARNERR:tl} == "yes":?${CFLAGS.warnerr}:}
_CXXFLAGS.warnerr=	${${WARNERR:tl} == "yes":?${CXXFLAGS.warnerr}:}

CFLAGS.warns     =	${CFLAGS.warns.${WARNS}}    ${_CFLAGS.warnerr}
CXXFLAGS.warns   =	${CXXFLAGS.warns.${WARNS}} ${_CXXFLAGS.warnerr}

NROFF_MAN2CAT ?=		${NROFF_MAN2CAT.${OPSYS}:U-mandoc -Tascii}

LD_TYPE  ?=			${LD_TYPE.${TARGET_OPSYS}:Ugnuld}

####################
OBJECT_FMT ?=			ELF

####################
LDFLAGS.soname.sunld =		-h lib${LIB}.so.${SHLIB_MAJOR}

LDFLAGS.soname.darwinld =	#
LDFLAGS.soname.gnuld =		-soname lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}
LDFLAGS.soname.hpld =		+h lib${LIB}.sl.${SHLIB_MAJOR}
LDFLAGS.soname.sunpro  =	${LDFLAGS.soname.sunld}

CFLAGS.cctold   ?=		-Wl,
CXXFLAGS.cctold ?=		-Wl,

LDFLAGS.soname.ld =		${LDFLAGS.soname.${LD_TYPE}:U}

.if ${LDREAL:U0} == ${CC:U0}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CC_TYPE}:U${LDFLAGS.soname.ld:@v@${CFLAGS.cctold}${v}@}}
.elif ${LDREAL:U0} == ${CXX:U0}
LDFLAGS.soname ?=		${LDFLAGS.soname.${CXX_TYPE}:U${LDFLAGS.soname.ld:@v@${CXXFLAGS.cctold}${v}@}}
.endif

############################################################
############################################################

.if ${SHLIB_EXT:U} == ".so" || ${SHLIB_EXT:U} == ".sl"

. if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1 =	${SHLIB_EXT}.${SHLIB_MAJOR}
.   if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2 =	${SHLIB_EXT}.${SHLIB_MAJOR}.${SHLIB_MINOR}
.     if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_FULLVERSION=${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
SHLIB_EXT3 =	${SHLIB_EXT}.${SHLIB_FULLVERSION}
.     else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}
.     endif # SHLIB_TEENY
.   else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}
.   endif # SHLIB_MINOR
. endif # SHLIB_MAJOR

SHLIB_EXTFULL =	${SHLIB_EXT}.${SHLIB_FULLVERSION}

.endif # SHLIB_EXT

############################################################
############################################################

.ifdef EXPORT_SYMBOLS
. if ${LD_TYPE} == "sunld" || ${LD_TYPE} == "gnuld"
CLEANFILES +=	${EXPORT_SYMBOLS}.tmp
lib${LIB}${SHLIB_EXTFULL}: ${EXPORT_SYMBOLS}.tmp
${EXPORT_SYMBOLS}.tmp:	${EXPORT_SYMBOLS}
	awk 'BEGIN {print "{ global:"} \
	     {sub(/#.*/, ""); if (NF>0) { $$1=$$1; print $$0 ";"} } \
	     END {print "local: *; };"}' ${.ALLSRC} > ${.TARGET}
. elif ${LD_TYPE} == "darwinld"
CLEANFILES +=	${EXPORT_SYMBOLS}.tmp
lib${LIB}${SHLIB_EXTFULL}: ${EXPORT_SYMBOLS}.tmp
${EXPORT_SYMBOLS}.tmp:	${EXPORT_SYMBOLS}
	awk '{sub(/#.*/, ""); if (NF>0) { $$1=$$1; print "_" $$0}}' ${.ALLSRC} > ${.TARGET}
. endif # sunld or darwinld

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

############################################################
############################################################


.endif #_MKC_PLATFORM_MK
