.for h in ${MKC_CHECK_HEADER_FILES} ${MKC_REQUIRE_HEADER_FILES}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if !defined(HAVE_HEADER_FILE.${var_suffix})
HAVE_HEADER_FILE.${var_suffix} != env ${mkc.environ} mkc_check_header -e ${h}
.  endif
.endfor # h

.for h in ${MKC_CHECK_HEADER_FILES}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if ${HAVE_HEADER_FILE.${var_suffix}}
MKC_CPPFLAGS  +=	-DHAVE_HEADER_FILE_${h:tu:C/.*,//:S|.|_|g:S|/|_|g}=${HAVE_HEADER_FILE.${h:C/.*,//:S|.|_|g:S|/|_|g}}
.  endif
.endfor # h

.for h in ${MKC_REQUIRE_HEADER_FILES}
var_suffix := ${h:C/.*,//:S|.|_|g:S|/|_|g}
.  if !${HAVE_HEADER_FILE.${var_suffix}}
_fake   !=   env ${mkc.environ} mkc_check_header -e -D ${h} && echo
MKC_ERR_MSG +=	"ERROR: header ${h} does not exist"
.  endif
.endfor # h

.undef MKC_CHECK_HEADER_FILES
.undef MKC_REQUIRE_HEADER_FILES
