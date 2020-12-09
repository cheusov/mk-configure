.for t in ${MKC_CHECK_TYPES:U} ${MKC_REQUIRE_TYPES:U}
var_suffix := ${t:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if !defined(HAVE_TYPE.${var_suffix})
HAVE_TYPE.${var_suffix}   !=   env ${mkc.environ} mkc_check_decl type ${t:S/:/ /g}
.  endif
.  if ${HAVE_TYPE.${var_suffix}}
.    if !defined(MKC_REQUIRE_TYPES) || empty(MKC_REQUIRE_TYPES:U:M${t})
MKC_CPPFLAGS  +=	-DHAVE_TYPE_${t:C/:.*,/:/:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.    endif
.  endif
.endfor

.ifdef MKC_REQUIRE_TYPES
.  for t in ${MKC_REQUIRE_TYPES}
.    if !${HAVE_TYPE.${t:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d type ${t:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of type ${t}"
.    endif
.  endfor
.endif

.undef MKC_CHECK_TYPES
.undef MKC_REQUIRE_TYPES
