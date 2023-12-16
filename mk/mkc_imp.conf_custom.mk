.for c in ${MKC_CHECK_CUSTOM} ${MKC_REQUIRE_CUSTOM}
. if !defined(CUSTOM.${c})
.   if !defined(MKC_CUSTOM_FN.${c})
MKC_CUSTOM_FN.${c} =	${c}.c
.   endif

.   if empty(MKC_CUSTOM_FN.${c}:M/*)
MKC_CUSTOM_FN.${c} :=	${MKC_CUSTOM_DIR}/${MKC_CUSTOM_FN.${c}}
.   endif

_opts      =		${"${MKC_CUSTOM_LINK.${c}:tl}" == "yes":?-l:}
_cppflags  =		${MKC_CUSTOM_CPPFLAGS.${c}:U}
_cflags    =		${MKC_CUSTOM_CFLAGS.${c}:U}
_cxxflags  =		${MKC_CUSTOM_CXXFLAGS.${c}:U}
_ldflags   =		${MKC_CUSTOM_LDFLAGS.${c}:U}
_ldadd     =		${MKC_CUSTOM_LDADD.${c}:U}
_cachename =		${MKC_CUSTOM_CACHE.${c}:Ucustom_${c}}
CUSTOM.${c} !=		env ${mkc.environ} mkc_check_custom -t ${_cachename:Q} ${_opts} ${MKC_CUSTOM_FN.${c}}

. endif # !defined(CUSTOM.${c})

. undef _cachename
. undef _opts
. undef _cppflags
. undef _cflags
. undef _cxxflags
. undef _ldflags
. undef _ldadd

. if !empty(CUSTOM.${c}) && ${CUSTOM.${c}} != 0
.   if empty(MKC_REQUIRE_CUSTOM:U:M${c}) && ${MKC_CUSTOM_NOAUTO.${c}:U:tl} != "yes"
MKC_CPPFLAGS  +=		-DCUSTOM_${c:tu}=${CUSTOM.${c}}
.   endif
. endif # !empty(CUSTOM.${c}) ...

.endfor # c

.for c in ${MKC_REQUIRE_CUSTOM}
. if empty(CUSTOM.${c}) || ${CUSTOM.${c}} == 0
_fake   !=   env ${mkc.environ} mkc_check_custom -t custom_${c:Q} -D ${MKC_CUSTOM_FN.${c}} && echo
MKC_ERR_MSG +=		"ERROR: custom test ${c} failed"
. endif
.endfor # c

.for c in ${MKC_CHECK_BUILTINS} ${MKC_REQUIRE_BUILTINS}
BUILTIN.${c} =		${CUSTOM.${c}}
.endfor # c in ${MKC_CHECK_BUILTINS} ${MKC_REQUIRE_BUILTINS}

.undef MKC_CHECK_CUSTOM
.undef MKC_REQUIRE_CUSTOM
