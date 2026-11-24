.include <mkc_imp.compiler_config.mk> # CC/CXX is set, detect compiler type

.if !empty(CC) && !empty(CXX)
. error "Either CC or CXX might be set"
.endif

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
CFLAGS.warnerr.tcc    =		-Werror
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

CFLAGS.warns.tcc.1 =		-Wimplicit-function-declaration
CFLAGS.warns.tcc.2 =		${CFLAGS.warns.tcc.1}
CFLAGS.warns.tcc.3 =		${CFLAGS.warns.tcc.2}
CFLAGS.warns.tcc.4 =		${CFLAGS.warns.tcc.3} -Wall

CFLAGS.pg          =		-pg

.for _warn_number in 1 2 3 4
CFLAGS.warns.${_warn_number}       =	${CFLAGS.warns.${CC_TYPE}.${_warn_number}}
_cc_vars                          +=	CFLAGS.warns.${_warn_number}
.endfor
_cc_vars                          +=	CFLAGS.pg

_CSTD_LIST := c89 gnu89 c99 gnu99 c11 gnu11 c17 gnu17
_CXXSTD_LIST := c++98 gnu++98 c++11 gnu++11 c++14 gnu++14 c++17 gnu++17 c++20 gnu++20 c++23 gnu++23

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
CFLAGS.ssp.pcc     =		-fstack-protector
CFLAGS.ssp        ?=		${CFLAGS.ssp.${CC_TYPE}:U}

CFLAGS.pic.gcc     =		-fPIC__-DPIC
CFLAGS.pic.clang   =		-fPIC__-DPIC
CFLAGS.pic.icc     =		-fPIC__-DPIC
CFLAGS.pic.pcc     =		-k__-DPIC
CFLAGS.pic.mipspro =		-KPIC
CFLAGS.pic.sunpro  =		-xcode=pic32 # -KPIC
CFLAGS.pic.hpc     =		+Z # +z
CFLAGS.pic.ibmc    =		-qpic=large # -qpic=small
CFLAGS.pic.decc    =		# ?
CFLAGS.pic        ?=		${CFLAGS.pic.${CC_TYPE}:U}

CFLAGS.pie.gcc   =		-fPIE__-DPIC
CFLAGS.pie.clang =		${CFLAGS.pie.gcc}
CFLAGS.pie.icc   =		-fPIE__-DPIC
CFLAGS.pie.pcc   =
CFLAGS.pie       =		${CFLAGS.pie.${CC_TYPE}.${TARGET_OPSYS}:U${CFLAGS.pie.${CC_TYPE}:U}}

CFLAGS.md          =		-MD
CFLAGS.mmd         =		-MMD

CLDFLAGS.relro     =		-Wl,-zrelro__-Wl,-znow
CXXLDFLAGS.relro   =		${CLDFLAGS.relro}

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
CLDFLAGS.pie             =	-fPIE__-pie
CXXLDFLAGS.pie           =	${CLDFLAGS.pie}
.endif

CLDFLAGS.shared.sunld    =	-Wl,-G
CLDFLAGS.shared.darwinld =
CLDFLAGS.shared.gnuld   =	-Wl,-shared
CLDFLAGS.shared.hpld    =	-Wl,-b__-Wl,+b__-Wl,${LIBDIR}

CLDFLAGS.shared.gcc     =	-shared
CLDFLAGS.shared.clang   =	-shared
CLDFLAGS.shared.pcc     =	-shared
CLDFLAGS.shared.icc     =	-shared
CLDFLAGS.shared.tcc     =	-shared
CLDFLAGS.shared.hpc     =	-b
CLDFLAGS.shared.imbc    =	-qmkshrobj
CLDFLAGS.shared.mipspro =	-shared
CLDFLAGS.shared.sunpro  =	-G
CLDFLAGS.shared.decc    =	-shared

CXXLDFLAGS.shared.sunld    =	${CLDFLAGS.shared.sunld}
CXXLDFLAGS.shared.darwinld =	${CLDFLAGS.shared.darwinld}
CXXLDFLAGS.shared.gnuld   =	${CLDFLAGS.shared.gnuld}
CXXLDFLAGS.shared.hpld    =	${CLDFLAGS.shared.hpld}

CXXLDFLAGS.shared.gcc     =	${CLDFLAGS.shared.gcc}
CXXLDFLAGS.shared.clang   =	${CLDFLAGS.shared.clang}
CXXLDFLAGS.shared.pcc     =	${CLDFLAGS.shared.pcc}
CXXLDFLAGS.shared.icc     =	${CLDFLAGS.shared.icc}
CXXLDFLAGS.shared.hpc     =	${CLDFLAGS.shared.hpc}
CXXLDFLAGS.shared.imbc    =	${CLDFLAGS.shared.ibmc}
CXXLDFLAGS.shared.mipspro =	${CLDFLAGS.shared.mipspro}
CXXLDFLAGS.shared.sunpro  =	${CLDFLAGS.shared.sunpro}
CXXLDFLAGS.shared.decc    =	${CLDFLAGS.shared.decc}

.if !empty(CC)
COMPILER_TYPE          =	${CC_TYPE}
.elif !empty(CXX)
COMPILER_TYPE          =	${CXX_TYPE}
.else
.error "No compiler found"
.endif

CLDFLAGS.expdyn         =	-rdynamic
CXXLDFLAGS.expdyn       =	${CLDFLAGS.expdyn}

_ccld_vars = CLDFLAGS.pie CLDFLAGS.relro CLDFLAGS.expdyn CLDFLAGS.shared

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

CXXFLAGS.pg          =		-pg

.for _warn_number in 1 2 3 4
CXXFLAGS.warns.${_warn_number}  =	${CXXFLAGS.warns.${CXX_TYPE}.${_warn_number}}
_cxx_vars                      +=	CXXFLAGS.warns.${_warn_number}
.endfor
_cxx_vars                      +=	CXXFLAGS.pg

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

CLDFLAGS.shared      =		${CFLAGS.pic}__${CLDFLAGS.shared.${COMPILER_TYPE}:U${CLDFLAGS.shared.${LD_TYPE}:U-shared}}
CXXLDFLAGS.shared    =		${CXXFLAGS.pic}__${CXXLDFLAGS.shared.${COMPILER_TYPE}:U${CXXLDFLAGS.shared.${LD_TYPE}:U-shared}}

_cxx_vars += CXXFLAGS.dflt CXXFLAGS.warnerr CXXFLAGS.ssp CXXFLAGS.pic CXXFLAGS.pie CXXFLAGS.md CXXFLAGS.mmd

_cxxld_vars = CXXLDFLAGS.pie CXXLDFLAGS.relro CXXLDFLAGS.expdyn CXXLDFLAGS.shared

#################################################

.for attr in aligned always_inline const noreturn pure printflike
_cc_vars += CUSTOM.attribute_${attr}
#_cxx_vars += CUSTOM.attribute_${attr}
CUSTOM.attribute_${attr}.new = ${CUSTOM.attribute_${attr}}
.endfor

MKC_FEATURES +=	macro
.include <mkc.conf.mk>

######
all: .PHONY
.for c in cc cxx
cc_cxx_capabilities_filename := mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET}.mk
. if !empty(${c:tu})
.   for v in ${_${c}_vars}
MKC_CHECK_${c:tu}_OPTS +=	${${v}}
.   endfor
.   for v in ${_${c}ld_vars}
MKC_CHECK_${c:tu}LD_OPTS +=	${${v}}
.   endfor
.   include <mkc.conf.mk>

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

CLDFLAGS.pie.gcc.new   :=	${CLDFLAGS.pie.gcc.new:U:tW:S/${CFLAGS.pie:S/__/ /g} //}
CLDFLAGS.pie.clang.new :=	${CLDFLAGS.pie.clang.new:U:tW:S/${CFLAGS.pie:S/__/ /g} //}
CLDFLAGS.shared.new    :=	${CLDFLAGS.shared.new:U:tW:S/${CFLAGS.pic:S/__/ /g} //}

CXXLDFLAGS.pie.gcc.new   :=	${CXXLDFLAGS.pie.gcc.new:U:tW:S/${CXXFLAGS.pie:S/__/ /g} //}
CXXLDFLAGS.pie.clang.new :=	${CXXLDFLAGS.pie.clang.new:U:tW:S/${CXXFLAGS.pie:S/__/ /g} //}
CXXLDFLAGS.shared.new    :=	${CXXLDFLAGS.shared.new:U:tW:S/${CXXFLAGS.pic:S/__/ /g} //}

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
. endif # !empty(${c:tu}
.endfor # .for c in cc cxx
