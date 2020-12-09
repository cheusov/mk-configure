######################################################
# <begin CFLAGS.check and CXXFLAGS.check>
.for c in ${CFLAGS.check}
MKC_CHECK_CC_OPTS +=	${c}
.endfor

.for c in ${CXXFLAGS.check}
MKC_CHECK_CXX_OPTS +=	${c}
.endfor

######################################################
# checks whether $CC accepts some arguments
.for a in ${MKC_CHECK_CC_OPTS}
.  if !defined(HAVE_CC_OPT.${a:S/=/_/g})
_cflags =	${a:S/__/ /g}
HAVE_CC_OPT.${a:S/=/_/g} !=	env ${mkc.environ} mkc_check_custom -t cc_option_${a:Q} -b -e -m 'if ${CC} -c accepts '${a:S/__/ /g:Q} ${_BUILTINSDIR}/easy.c
.    undef _cflags
.  endif # !defined(HAVE_CC_OPT.${a})
.endfor # a

.undef MKC_CHECK_CC_OPTS

# checks whether $CXX accepts some arguments
.for a in ${MKC_CHECK_CXX_OPTS}
.  if !defined(HAVE_CXX_OPT.${a:S/=/_/g})
_cxxflags =	${a:S/__/ /g}
HAVE_CXX_OPT.${a:S/=/_/g} !=	env ${mkc.environ} mkc_check_custom -t cxx_option_${a:Q} -b -e -m 'if ${CXX} -c accepts '${a:S/__/ /g:Q} ${_BUILTINSDIR}/easy.cc
.    undef _cxxflags
.  endif # !defined(HAVE_CXX_OPT.${a})
.endfor # a

.undef MKC_CHECK_CXX_OPTS

######################################################
# checks whether $CC accepts some arguments
.for a in ${MKC_CHECK_CCLD_OPTS}
.  if !defined(HAVE_CCLD_OPT.${a:S/=/_/g})
_cflags =	${a:S/__/ /g}
HAVE_CCLD_OPT.${a:S/=/_/g} !=	env ${mkc.environ} mkc_check_custom -l -t ccld_option_${a:Q} -b -e -m 'if ${CC} accepts '${a:S/__/ /g:Q} ${_BUILTINSDIR}/easy.c
.    undef _cflags
.  endif # !defined(HAVE_CCLD_OPT.${a})
.endfor # a

.undef MKC_CHECK_CCLD_OPTS

# checks whether $CXX accepts some arguments
.for a in ${MKC_CHECK_CXXLD_OPTS}
.  if !defined(HAVE_CXXLD_OPT.${a:S/=/_/g})
_cxxflags =	${a:S/__/ /g}
HAVE_CXXLD_OPT.${a:S/=/_/g} !=	env ${mkc.environ} mkc_check_custom -l -t cxxld_option_${a:Q} -b -e -m 'if ${CXX} accepts '${a:S/__/ /g:Q} ${_BUILTINSDIR}/easy.cc
.    undef _cxxflags
.  endif # !defined(HAVE_CXXLD_OPT.${a})
.endfor # a

.undef MKC_CHECK_CXXLD_OPTS

######################################################
# <end CFLAGS.check and CXXFLAGS.check>
.for c in ${CFLAGS.check}
.   if ${HAVE_CC_OPT.${c:S/=/_/g}:U0} == 1
MKC_CFLAGS +=	${c:S/__/ /g}
.   endif
.endfor

.undef CFLAGS.check

.for c in ${CXXFLAGS.check}
.   if ${HAVE_CXX_OPT.${c:S/=/_/g}:U0} == 1
MKC_CXXFLAGS +=	${c:S/__/ /g}
.   endif
.endfor

.undef CXXFLAGS.check
