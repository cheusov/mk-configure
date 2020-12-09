.for d in ${MKC_CHECK_DEFINES:U} ${MKC_REQUIRE_DEFINES:U}
var_suffix := ${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if !defined(HAVE_DEFINE.${var_suffix})
HAVE_DEFINE.${var_suffix}   !=   env ${mkc.environ} mkc_check_decl define ${d:S/:/ /g}
.  endif
.  if ${HAVE_DEFINE.${var_suffix}}
.    if !defined(MKC_REQUIRE_DEFINES) || empty(MKC_REQUIRE_DEFINES:U:M${d})
MKC_CPPFLAGS  +=	-DHAVE_DEFINE_${d:C/:.*,/:/:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.    endif
.  endif
.endfor

.ifdef MKC_REQUIRE_DEFINES
.  for d in ${MKC_REQUIRE_DEFINES}
.    if !${HAVE_DEFINE.${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d define ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of define ${d}"
.    endif
.  endfor
.endif

.undef MKC_CHECK_DEFINES
.undef MKC_REQUIRE_DEFINES
