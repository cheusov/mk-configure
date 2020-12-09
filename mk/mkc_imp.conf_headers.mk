.for h in ${MKC_CHECK_HEADERS} ${MKC_REQUIRE_HEADERS}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if !defined(HAVE_HEADER.${var_suffix})
HAVE_HEADER.${var_suffix}   !=   env ${mkc.environ} mkc_check_header ${h}
.  endif
.endfor

.for h in ${MKC_CHECK_HEADERS}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if ${HAVE_HEADER.${var_suffix}}
MKC_CPPFLAGS  +=	-DHAVE_HEADER_${h:tu:C/.*,//:S|.|_|g:S|/|_|g}=${HAVE_HEADER.${h:C/.*,//:S|.|_|g:S|/|_|g}}
.  endif
.endfor

.for h in ${MKC_REQUIRE_HEADERS}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if !${HAVE_HEADER.${var_suffix}}
_fake   !=   env ${mkc.environ} mkc_check_header -d ${h} && echo
MKC_ERR_MSG +=	"ERROR: header ${h} does not exist or is not compilable"
.  endif
.endfor

.undef MKC_CHECK_HEADERS
.undef MKC_REQUIRE_HEADERS
