.for t in ${MKC_CHECK_SIZEOF:U}
var_suffix := ${t:C/:.*,/:/:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g}
.  if !defined(SIZEOF.${var_suffix})
SIZEOF.${var_suffix}   !=   env ${mkc.environ} mkc_check_sizeof ${t:S/:/ /g}
.  endif
.  if ${SIZEOF.${var_suffix}} != failed
MKC_CPPFLAGS  +=  -DSIZEOF_${t:C/:.*,/:/:S/-/_/g:S| |_|g:S|*|P|g:S|:|_|g:S|.|_|g:S|/|_|g:tu}=${SIZEOF.${t:C/:.*,/:/:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g}}
.  endif
.endfor

.undef MKC_CHECK_SIZEOF
