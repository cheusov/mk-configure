#################################################
### C variables
CFLAGS.dflt.clang     =		-Qunused-arguments -Werror=implicit-function-declaration
CFLAGS.dflt.icc       =		-we147 -we10006 # 147 is required for MKC_CHECK_PROTOTYPES
CFLAGS.dflt.sunpro    =		-errtags -errwarn=E_ATTRIBUTE_UNKNOWN
CFLAGS.dflt           =		${CFLAGS.dflt.${CC_TYPE}}

CFLAGS.warnerr.gcc    =		-Werror
CFLAGS.warnerr.clang  =		-Werror
CFLAGS.warnerr.icc    =		-Werror
CFLAGS.warnerr.sunpro =		-errwarn=%all
CFLAGS.warnerr.armcc  =		--diag_error=warning
CFLAGS.warnerr        =		${CFLAGS.warnerr.${CC_TYPE}}

CFLAGS.warns.gcc.1 =		-Wall -Wstrict-prototypes -Wmissing-prototypes \
				-Wpointer-arith -Wreturn-type
CFLAGS.warns.gcc.2 =		${CFLAGS.warns.gcc.1} -Wswitch -Wshadow
CFLAGS.warns.gcc.3 =		${CFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wno-unused-parameter
CFLAGS.warns.gcc.4 =		${CFLAGS.warns.gcc.3}

CFLAGS.warns.clang.1 =		${CFLAGS.warns.gcc.1}
CFLAGS.warns.clang.2 =		${CFLAGS.warns.gcc.2}
CFLAGS.warns.clang.3 =		${CFLAGS.warns.gcc.3}
CFLAGS.warns.clang.4 =		${CFLAGS.warns.gcc.4}

CFLAGS.warns.icc.1 =		-Wall -we1011
CFLAGS.warns.icc.2 =		${CFLAGS.warns.icc.1}
CFLAGS.warns.icc.3 =		${CFLAGS.warns.icc.2}
CFLAGS.warns.icc.4 =		${CFLAGS.warns.icc.3}

CFLAGS.warns.hpc.0 =		-w3
CFLAGS.warns.hpc.1 =		-w2
CFLAGS.warns.hpc.2 =		-w2
CFLAGS.warns.hpc.3 =		-w2
CFLAGS.warns.hpc.4 =		-w2

.for _warn_number in 1 2 3 4
CFLAGS.warns.${_warn_number}       =	${CFLAGS.warns.${CC_TYPE}.${_warn_number}}
_cc_vars                          +=	CFLAGS.warns.${_warn_number}
.endfor

_CSTD_LIST := c89 gnu89 c99 gnu99 c11 gnu11 c17 gnu17
_CXXSTD_LIST := c++98 gnu++98 c++11 gnu++11 c++14 gnu++14 c++17 gnu++17

.for c in C CXX
. for std in ${_${c}STD_LIST}
.  for t in gcc clang icc pcc sunpro
${c}FLAGS.std.${std}.${t} :=		-std=${std}
.  endfor
. endfor
.endfor

CFLAGS.ssp.gcc     =		-fstack-protector -Wstack-protector --param__ssp-buffer-size=1
CFLAGS.ssp.clang   =		${CFLAGS.ssp.gcc}
CFLAGS.ssp.icc     =		-fstack-security-check
CFLAGS.ssp.ibmc    =		-qstackprotect
CFLAGS.ssp        ?=		${CFLAGS.ssp.${CC_TYPE}:U}

CFLAGS.pic.gcc     =		-fPIC__-DPIC
CFLAGS.pic.clang   =		-fPIC__-DPIC
CFLAGS.pic.icc     =		-fPIC__-DPIC
CFLAGS.pic.pcc     =		-k -DPIC
CFLAGS.pic.mipspro =		-KPIC
CFLAGS.pic.sunpro  =		-xcode=pic32 # -KPIC
CFLAGS.pic.hpc     =		+Z # +z
CFLAGS.pic.ibmc    =		-qpic=large # -qpic=small
CFLAGS.pic.decc    =		# ?
CFLAGS.pic        ?=		${CFLAGS.pic.${CC_TYPE}:U}

CFLAGS.pie.gcc   =		-fPIE__-DPIC
CFLAGS.pie.clang =		${CFLAGS.pie.gcc}
CFLAGS.pie.icc   =		-fPIE__-DPIC
CFLAGS.pie       =		${CFLAGS.pie.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pie.${CC_TYPE}:U}}

CFLAGS.md          =		-MD
CFLAGS.mmd         =		-MMD

LDFLAGS.relro  =		-Wl,-zrelro__-Wl,-znow

_cc_vars += CFLAGS.dflt CFLAGS.warnerr CFLAGS.ssp CFLAGS.pic CFLAGS.pie CFLAGS.md CFLAGS.mmd

.for std in ${_CSTD_LIST}
CFLAGS.std.${std} =	${CFLAGS.std.${std}.${CC_TYPE}}
_cc_vars +=	CFLAGS.std.${std}
.endfor
.for std in ${_CXXSTD_LIST}
CXXFLAGS.std.${std} =	${CXXFLAGS.std.${std}.${CXX_TYPE}}
_cxx_vars +=	CXXFLAGS.std.${std}
.endfor

.undef _CSTD_LIST
.undef _CXXSTD_LIST

.if ${TARGET_OPSYS} != "Darwin"
LDFLAGS.pie             =	-fPIE__-pie
.endif

LDFLAGS.shared.sunld    =	-Wl,-G
LDFLAGS.shared.darwinld =
LDFLAGS.shared.gnuld   =	-Wl,-shared
LDFLAGS.shared.hpld    =	-Wl,-b__-Wl,+b__-Wl,${LIBDIR}

LDFLAGS.shared.gcc     =	-shared
LDFLAGS.shared.clang   =	-shared
LDFLAGS.shared.pcc     =	-shared
LDFLAGS.shared.icc     =	-shared
LDFLAGS.shared.hpc     =	-b
LDFLAGS.shared.imbc    =	-qmkshrobj
LDFLAGS.shared.mipspro =	-shared
LDFLAGS.shared.sunpro  =	-G
LDFLAGS.shared.decc    =	-shared

.if !empty(CC)
COMPILER_TYPE          =	${CC_TYPE}
.elif !empty(CXX)
COMPILER_TYPE          =	${CXX_TYPE}
.else
.error "No compiler found"
.endif

LDFLAGS.shared         =	${LDFLAGS.shared.${COMPILER_TYPE}:U${LDFLAGS.shared.${LD_TYPE}:U-shared}}

LDFLAGS.expdyn         =	-rdynamic

_ccld_vars = LDFLAGS.pie LDFLAGS.relro LDFLAGS.expdyn \
    LDFLAGS.shared

### C++ variables
CXXFLAGS.dflt.clang   =	${CFLAGS.dflt.clang}
CXXFLAGS.dflt.icc     =	${CFLAGS.dflt.icc}
CXXFLAGS.dflt         =	${CXXFLAGS.dflt.${CXX_TYPE}}

CXXFLAGS.warnerr.gcc   =	${CFLAGS.warnerr.gcc}
CXXFLAGS.warnerr.clang =	${CFLAGS.warnerr.gcc}
CXXFLAGS.warnerr       =	${CXXFLAGS.warnerr.${CXX_TYPE}}

CXXFLAGS.warns.gcc.1 =		-Wold-style-cast -Wctor-dtor-privacy -Wreturn-type \
				-Wnon-virtual-dtor -Wreorder -Wno-deprecated \
				-Wno-non-template-friend -Woverloaded-virtual \
				-Wno-pmf-conversions -Wsign-promo -Wsynth \
				-Werror=return-type
CXXFLAGS.warns.gcc.2 =		${CXXFLAGS.warns.gcc.1} -Wswitch -Wshadow
CXXFLAGS.warns.gcc.3 =		${CXXFLAGS.warns.gcc.2} -Wcast-qual -Wwrite-strings \
				-Wno-unused-parameter
CXXFLAGS.warns.gcc.4 =		${CXXFLAGS.warns.gcc.3}

CXXFLAGS.warns.clang.1 =	${CXXFLAGS.warns.gcc.1}
CXXFLAGS.warns.clang.2 =	${CXXFLAGS.warns.gcc.2}
CXXFLAGS.warns.clang.3 =	${CXXFLAGS.warns.gcc.3}
CXXFLAGS.warns.clang.4 =	${CXXFLAGS.warns.gcc.4}

CXXFLAGS.warns.hpc.0 =		${CFLAGS.warns.hpc.0}
CXXFLAGS.warns.hpc.1 =		${CFLAGS.warns.hpc.1}
CXXFLAGS.warns.hpc.2 =		${CFLAGS.warns.hpc.2}
CXXFLAGS.warns.hpc.3 =		${CFLAGS.warns.hpc.3}
CXXFLAGS.warns.hpc.4 =		${CFLAGS.warns.hpc.4}

CXXFLAGS.warns.icc.1 =		${CFLAGS.warns.icc.1}
CXXFLAGS.warns.icc.2 =		${CFLAGS.warns.icc.2}
CXXFLAGS.warns.icc.3 =		${CFLAGS.warns.icc.3}
CXXFLAGS.warns.icc.4 =		${CFLAGS.warns.icc.4}

.for _warn_number in 1 2 3 4
CXXFLAGS.warns.${_warn_number}  =	${CXXFLAGS.warns.${CXX_TYPE}.${_warn_number}}
_cxx_vars                      +=	CXXFLAGS.warns.${_warn_number}
.endfor

CXXFLAGS.ssp.gcc     =		${CFLAGS.ssp.gcc}
CXXFLAGS.ssp.clang   =		${CFLAGS.ssp.clang}
CXXFLAGS.ssp.icc     =		${CFLAGS.ssp.icc}
CXXFLAGS.ssp.ibmc    =		${CFLAGS.ssp.ibmc}
CXXFLAGS.ssp         =		${CXXFLAGS.ssp.${CXX_TYPE}:U}

CXXFLAGS.pic.gcc     =		${CFLAGS.pic.gcc}
CXXFLAGS.pic.clang   =		${CFLAGS.pic.clang}
CXXFLAGS.pic.icc     =		${CFLAGS.pic.icc}
CXXFLAGS.pic.pcc     =		${CFLAGS.pic.pcc}
CXXFLAGS.pic.mipspro =		${CFLAGS.pic.mipspro}
CXXFLAGS.pic.sunpro  =		${CFLAGS.pic.sunpro}
CXXFLAGS.pic.hpc     =		${CFLAGS.pic.hpc}
CXXFLAGS.pic.ibmc    =		${CFLAGS.pic.ibmc}
CXXFLAGS.pic.decc    =		${CFLAGS.pic.decc}
CXXFLAGS.pic        ?=		${CXXFLAGS.pic.${CXX_TYPE}:U}

CXXFLAGS.pie.gcc     =		${CFLAGS.pie.gcc}
CXXFLAGS.pie.clang   =		${CFLAGS.pie.clang}
CXXFLAGS.pie.icc     =		${CFLAGS.pie.icc}
CXXFLAGS.pie         =		${CXXFLAGS.pie.${CXX_TYPE}.${TARGET_OPSYS}:U${CXXFLAGS.pie.${CXX_TYPE}:U}}

CXXFLAGS.md          =		-MD
CXXFLAGS.mmd         =		-MMD

_cxx_vars += CXXFLAGS.dflt CXXFLAGS.warnerr CXXFLAGS.ssp CXXFLAGS.pic CXXFLAGS.pie \
    CXXFLAGS.md CXXFLAGS.mmd

_cxxld_vars = LDFLAGS.pie LDFLAGS.relro LDFLAGS.expdyn \
    LDFLAGS.shared

#################################################
.for c in cc cxx
cc_cxx_capabilities_filename := mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET}.mk
. if !empty(${c:tu})
.   for v in ${_${c}_vars}
MKC_CHECK_${c:tu}_OPTS +=	${${v}}
.   endfor
.   for v in ${_${c}ld_vars}
MKC_CHECK_${c:tu}LD_OPTS +=	${${v}}
.   endfor
.   include "mkc.conf.mk"

.   for v in ${_${c}_vars}
.     for _opt in ${${v}}
.       if ${HAVE_${c:tu}_OPT.${_opt:S/=/_/}:U} == 1
${v}.new +=	${_opt:S/__/ /g}
.       endif
.     endfor
.   endfor
.   for v in ${_${c}ld_vars}
.     for _opt in ${${v}}
.       if ${HAVE_${c:tu}LD_OPT.${_opt:S/=/_/}:U} == 1
${v}.new +=	${_opt:S/__/ /g}
.       endif
.     endfor
.   endfor

LDFLAGS.pie.gcc.new   :=	${LDFLAGS.pie.gcc.new:U:tW:S/-fPIE -DPIC //}
LDFLAGS.pie.clang.new :=	${LDFLAGS.pie.clang.new:U:tW:S/-fPIE -DPIC //}

######
.   ifdef RECURS
all: ${cc_cxx_capabilities_filename}
${cc_cxx_capabilities_filename}: .PHONY # always regenerate!
	@printf '' > $@.tmp;
.   for v in ${_${c}_vars}
	@echo ${v} = ${${v}.new} >> $@.tmp;
.   endfor
	@printf '' >> $@.tmp;
.   for v in ${_${c}ld_vars}
	@echo ${v} = ${${v}.new} >> $@.tmp;
.   endfor
	@mv $@.tmp $@

.   endif # RECURS
. endif # !empty(${c:tu}
.endfor # .for c in cc cxx

#################################################
USE_CC_COMPILERS  ?=	${CC}
USE_CXX_COMPILERS ?=	${CXX}

.ifndef RECURS
post_all:
. for CC in ${USE_CC_COMPILERS:U}
	@env ${MAKE} ${MAKE_FLAGS} ${COMPILER_SETTINGS_MK:U} all USE_CXX_COMPILERS= \
	    MKCHECKS=yes MKC_NOCACHE=1 RECURS=1 CC=${CC} CXX= src_type=cc
. endfor # CC
. for CXX in ${USE_CXX_COMPILERS:U}
	@env ${MAKE} ${MAKE_FLAGS} ${COMPILER_SETTINGS_MK:U} all USE_CC_COMPILERS= \
	    MKCHECKS=yes MKC_NOCACHE=1 RECURS=1 CC= CXX=${CXX} src_type=cxx
. endfor # CXX
.endif # RECURS
