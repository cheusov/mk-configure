#################################################
### C variables
CFLAGS.dflt.clang     =		-Qunused-arguments -Werror=implicit-function-declaration
CFLAGS.dflt.icc       =		-we147 # 147 is required for MKC_CHECK_PROTOTYPES
CFLAGS.dflt.sunpro    =		-errtags

CFLAGS.warnerr.gcc =		-Werror
CFLAGS.warnerr.clang  =		-Werror
CFLAGS.warnerr.icc    =		-Werror
CFLAGS.warnerr.sunpro =		-errwarn=%all

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

CFLAGS.ssp.gcc =		-fstack-protector -Wstack-protector --param__ssp-buffer-size=1
CFLAGS.ssp.clang =		${CFLAGS.ssp.gcc}
CFLAGS.ssp.icc =		-fstack-security-check
CFLAGS.ssp.ibmc =		-qstackprotect

CFLAGS.pic.gcc =		-fPIC__-DPIC
CFLAGS.pic.clang =		-fPIC__-DPIC
CFLAGS.pic.icc =		-fPIC__-DPIC
CFLAGS.pic.pcc =		-k -DPIC
CFLAGS.pic.mipspro =		-KPIC
CFLAGS.pic.sunpro =		-xcode=pic32 # -KPIC
CFLAGS.pic.hpc =		+Z # +z
CFLAGS.pic.ibmc =		-qpic=large # -qpic=small
CFLAGS.pic.decc =		# ?

CFLAGS.pie.gcc =		-fPIE__-DPIC
CFLAGS.pie.clang =		${CFLAGS.pie.gcc}
CFLAGS.pie.icc =		-fPIE__-DPIC

LDFLAGS.relro  =		-Wl,-zrelro__-Wl,-znow

_cc_vars = CFLAGS.dflt.${CC_TYPE} CFLAGS.warnerr.${CC_TYPE} CFLAGS.warns.${CC_TYPE}.1 \
    CFLAGS.warns.${CC_TYPE}.2 CFLAGS.warns.${CC_TYPE}.3 CFLAGS.warns.${CC_TYPE}.4 \
    CFLAGS.ssp.${CC_TYPE} CFLAGS.pic.${CC_TYPE} CFLAGS.pie.${CC_TYPE}

LDFLAGS.pie.gcc   =		-fPIE__-DPIC__-pie
LDFLAGS.pie.clang =		-fPIE__-DPIC__-pie

_ccld_vars = LDFLAGS.pie.${CC_TYPE} LDFLAGS.relro

### C++ variables
CXXFLAGS.dflt.clang   =		${CFLAGS.dflt.clang}
CXXFLAGS.dflt.icc     =		${CFLAGS.dflt.icc}

CXXFLAGS.warnerr.gcc =		${CFLAGS.warnerr.gcc}
CXXFLAGS.warnerr.clang =	${CXXFLAGS.warnerr.gcc}

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

CXXFLAGS.ssp.gcc     =		${CFLAGS.ssp.gcc}
CXXFLAGS.ssp.clang   =		${CFLAGS.ssp.clang}
CXXFLAGS.ssp.icc     =		${CFLAGS.ssp.icc}
CXXFLAGS.ssp.ibmc    =		${CFLAGS.ssp.ibmc}

CXXFLAGS.pic.gcc     =		${CFLAGS.pic.gcc}
CXXFLAGS.pic.clang   =		${CFLAGS.pic.clang}
CXXFLAGS.pic.icc     =		${CFLAGS.pic.icc}
CXXFLAGS.pic.pcc     =		${CFLAGS.pic.pcc}
CXXFLAGS.pic.mipspro =		${CFLAGS.pic.mipspro}
CXXFLAGS.pic.sunpro  =		${CFLAGS.pic.sunpro}
CXXFLAGS.pic.hpc     =		${CFLAGS.pic.hpc}
CXXFLAGS.pic.ibmc    =		${CFLAGS.pic.ibmc}
CXXFLAGS.pic.decc    =		${CFLAGS.pic.decc}

CXXFLAGS.pie.gcc     =		${CFLAGS.pie.gcc}
CXXFLAGS.pie.clang   =		${CFLAGS.pie.clang}
CXXFLAGS.pie.icc     =		${CFLAGS.pie.icc}

_cxx_vars = CXXFLAGS.dflt.${CXX_TYPE} CXXFLAGS.warnerr.${CXX_TYPE} \
    CXXFLAGS.warns.${CXX_TYPE}.1 CXXFLAGS.warns.${CXX_TYPE}.2 \
    CXXFLAGS.warns.${CXX_TYPE}.3 CXXFLAGS.warns.${CXX_TYPE}.4 \
    CXXFLAGS.ssp.${CXX_TYPE} CXXFLAGS.pic.${CXX_TYPE} CXXFLAGS.pie.${CXX_TYPE}

_cxxld_vars = LDFLAGS.pie.${CXX_TYPE} LDFLAGS.relro

#################################################
.for c in cc cxx
.if !empty(${c:tu})
.   for v in ${_${c}_vars}
MKC_CHECK_${c:tu}_OPTS +=	${${v}}
.   endfor
.   for v in ${_${c}ld_vars}
MKC_CHECK_${c:tu}LD_OPTS +=	${${v}}
.   endfor
.   include <mkc.conf.mk>

.   for v in ${_${c}_vars}
.       for _opt in ${${v}}
.           if ${HAVE_${c:tu}_OPT.${_opt:S/=/_/}:U} == 1
${v}.new +=	${_opt:S/__/ /g}
.           endif
.       endfor
.   endfor
.   for v in ${_${c}ld_vars}
.       for _opt in ${${v}}
.           if ${HAVE_${c:tu}LD_OPT.${_opt:S/=/_/}:U} == 1
${v}.new +=	${_opt:S/__/ /g}
.           endif
.       endfor
.   endfor

LDFLAGS.pie.gcc.new   :=	${LDFLAGS.pie.gcc.new:U:tW:S/-fPIE -DPIC //}
LDFLAGS.pie.clang.new :=	${LDFLAGS.pie.clang.new:U:tW:S/-fPIE -DPIC //}

######
.ifdef RECURS
all: post_all
post_all: mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}.mk
mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}.mk: .PHONY # always regenerate!
	@printf '' > $@.tmp;
.   for v in ${_${c}_vars}
	@echo ${v} = ${${v}.new} >> $@.tmp;
.   endfor
	@printf '' >> $@.tmp;
.   for v in ${_${c}ld_vars}
	@echo ${v} = ${${v}.new} >> $@.tmp;
.   endfor
	@mv $@.tmp $@

.endif # RECURS
.endif # !empty(${c:tu}
.endfor # .for c in cc cxx

#################################################
USE_CC_COMPILERS  ?=	${CC}
USE_CXX_COMPILERS ?=	${CXX}

.ifndef RECURS
post_all:
.for CC in ${USE_CC_COMPILERS:U}
	@env ${MAKE} ${MAKE_FLAGS} ${COMPILER_SETTINGS_MK:U} all USE_CXX_COMPILERS= \
	    MKCHECKS=yes MKC_NOCACHE=1 RECURS=1 CC=${CC} CXX= src_type=cc
.endfor # CC
.for CXX in ${USE_CXX_COMPILERS:U}
	@env ${MAKE} ${MAKE_FLAGS} ${COMPILER_SETTINGS_MK:U} all USE_CC_COMPILERS= \
	    MKCHECKS=yes MKC_NOCACHE=1 RECURS=1 CC= CXX=${CXX} src_type=cxx
.endfor # CXX
.endif # RECURS
