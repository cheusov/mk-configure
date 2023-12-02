.for m in ${MKC_CHECK_MEMBERS:U} ${MKC_REQUIRE_MEMBERS:U}
var_suffix := ${m:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g}
.  if !defined(HAVE_MEMBER.${var_suffix})
HAVE_MEMBER.${var_suffix}   !=   env ${mkc.environ} mkc_check_decl member ${m:S/:/ /g}
.  endif
.  if ${HAVE_MEMBER.${var_suffix}}
.    if !defined(MKC_REQUIRE_MEMBERS) || empty(MKC_REQUIRE_MEMBERS:U:M${m})
MKC_CPPFLAGS  +=	-DHAVE_MEMBER_${m:C/:.*,/:/:tu:S/:/_/g:S/./_/g:S|/|_|g:S/-/_/g}=1
.    endif
.  endif
.endfor

.for m in ${MKC_REQUIRE_MEMBERS:U}
.  if !${HAVE_MEMBER.${m:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -D member ${m:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find member ${m}"
.  endif
.endfor

.undef MKC_CHECK_MEMBERS
.undef MKC_REQUIRE_MEMBERS
