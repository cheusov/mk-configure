.for f in ${MKC_CHECK_FUNCLIBS:U} ${MKC_SOURCE_FUNCLIBS:U} ${MKC_REQUIRE_FUNCLIBS:U}
var_suffix1 := ${f:S/:/./g}
var_suffix2 := ${f:C/:.*//}
.  if !defined(HAVE_FUNCLIB.${var_suffix1})
HAVE_FUNCLIB.${var_suffix1} !=	env ${mkc.environ} mkc_check_funclib ${f:S/:/ /g}
.  endif
.  if !defined(HAVE_FUNCLIB.${var_suffix2})
HAVE_FUNCLIB.${var_suffix2} !=	env ${mkc.environ} mkc_check_funclib ${f:C/:.*//}
.  endif
.  if ${HAVE_FUNCLIB.${var_suffix1}} && !${HAVE_FUNCLIB.${var_suffix2}}
.    if empty(MKC_NOAUTO_FUNCLIBS:U:S/:/./g:M${var_suffix1}) && \
       empty(MKC_NOAUTO_FUNCLIBS:U:M1)
MKC_LDADD +=	-l${f:C/^.*://}
.    endif
.  endif

.  if !empty(_MKC_SOURCE_FUNCS) && !${HAVE_FUNCLIB.${var_suffix1}} && \
     !${HAVE_FUNCLIB.${var_suffix2}} && !empty(_MKC_SOURCE_FUNCS:M${var_suffix2})
MKC_SRCS +=	${MKC_SOURCE_DIR.${f:C/:.*//}.c:U${MKC_SOURCE_DIR}}/${f:C/:.*//}.c
.  endif
.endfor # f

.ifdef MKC_REQUIRE_FUNCLIBS
.  for f in ${MKC_REQUIRE_FUNCLIBS}
.    if !${HAVE_FUNCLIB.${f:S/:/./g}} && !${HAVE_FUNCLIB.${f:C/:.*//}}
_fake   !=   env ${mkc.environ} mkc_check_funclib -D ${f:C/:.*//} && echo
_fake   !=   env ${mkc.environ} mkc_check_funclib -D ${f:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find function ${f}"
.    endif
.  endfor # f
.endif

.undef MKC_CHECK_FUNCLIBS
.undef MKC_REQUIRE_FUNCLIBS
