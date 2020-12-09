.for d in ${MKC_CHECK_VARS:U} ${MKC_REQUIRE_VARS:U}
var_suffix := ${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if !defined(HAVE_VAR.${var_suffix})
HAVE_VAR.${var_suffix}   !=   env ${mkc.environ} mkc_check_decl variable ${d:S/:/ /g}
.  endif
.  if ${HAVE_VAR.${var_suffix}}
.    if !defined(MKC_REQUIRE_VARS) || empty(MKC_REQUIRE_VARS:U:M${d})
MKC_CPPFLAGS  +=	-DHAVE_VAR_${d:C/:.*,/:/:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.    endif
.  endif
.endfor

.ifdef MKC_REQUIRE_VARS
.  for d in ${MKC_REQUIRE_VARS}
.    if !${HAVE_VAR.${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d variable ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of variable ${d}"
.    endif
.  endfor
.endif

.undef MKC_CHECK_VARS
.undef MKC_REQUIRE_VARS
