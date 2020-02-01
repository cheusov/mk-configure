#################################################
### C variables
CFLAGS.dflt.clang     =		-Qunused-arguments -Werror=implicit-function-declaration
CFLAGS.dflt.icc       =		-we147 # 147 is required for MKC_CHECK_PROTOTYPES

CFLAGS.warnerr.gcc =		-Werror
CFLAGS.warnerr.clang  =		-Werror
CFLAGS.warnerr.icc    =		-Werror
CFLAGS.warnerr.sunpro =		-errwarn=%all

CFLAGS.warns.gcc.1 =		-Wall -Wstrict-prototypes -Wmissing-prototypes \
				-Wpointer-arith
CFLAGS.warns.gcc.2 =		${CFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
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

CFLAGS.pic.gcc =		-fPIC -DPIC
CFLAGS.pic.clang =		-fPIC -DPIC
CFLAGS.pic.icc =		-fPIC -DPIC
CFLAGS.pic.pcc =		-k -DPIC
CFLAGS.pic.mipspro =		-KPIC
CFLAGS.pic.sunpro =		-xcode=pic32 # -KPIC
CFLAGS.pic.hpc =		+Z # +z
CFLAGS.pic.ibmc =		-qpic=large # -qpic=small
CFLAGS.pic.decc =		# ?

CFLAGS.pie.gcc =		-fPIE -DPIC
CFLAGS.pie.clang =		${CFLAGS.pie.gcc}
CFLAGS.pie.icc =		-fPIE -DPIC

_cc_vars = CFLAGS.dflt.${CC_TYPE} CFLAGS.warnerr.${CC_TYPE} CFLAGS.warns.${CC_TYPE}.1 \
    CFLAGS.warns.${CC_TYPE}.2 CFLAGS.warns.${CC_TYPE}.3 CFLAGS.warns.${CC_TYPE}.4 \
    CFLAGS.ssp.${CC_TYPE} CFLAGS.pic.${CC_TYPE} CFLAGS.pie.${CC_TYPE}

### C++ variables
CXXFLAGS.dflt.clang   =		${CFLAGS.dflt.clang}
CXXFLAGS.dflt.icc     =		${CFLAGS.dflt.icc}

CXXFLAGS.warnerr.gcc =		${CFLAGS.warnerr.gcc}
CXXFLAGS.warnerr.clang =	${CXXFLAGS.warnerr.gcc}

CXXFLAGS.warns.gcc.1 =		-Wold-style-cast -Wctor-dtor-privacy \
				-Wnon-virtual-dtor -Wreorder -Wno-deprecated \
				-Wno-non-template-friend -Woverloaded-virtual \
				-Wno-pmf-conversions -Wsign-promo -Wsynth
CXXFLAGS.warns.gcc.2 =		${CXXFLAGS.warns.gcc.1} -Wreturn-type -Wswitch -Wshadow
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
    CXXFLAGS.ssp.${CC_TYPE} CXXFLAGS.pic.${CC_TYPE} CXXFLAGS.pie.${CC_TYPE}

#################################################
.for c in cc cxx
.   for v in ${_${c}_vars}
MKC_CHECK_${c:tu}_OPTS +=	${${v}}
.   endfor

.   include <mkc.configure.mk>

.   for v in ${_${c}_vars}
#.   info "v=${v} ${${v}}"
.       for _opt in ${${v}}
.           if ${HAVE_${c:tu}_OPT.${_opt:S/=/_/}:U} == 1
#.info "${v}.new +=	${_opt}"
${v}.new +=	${_opt:S/__/ /g}
.          endif
.       endfor
.    endfor

###
mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}.mk:
	@printf '' '' > $@.tmp;
.for v in ${_${c}_vars}
	@echo ${v} = ${${v}.new} >> $@.tmp;
.endfor
	@mv $@.tmp $@
.endfor
