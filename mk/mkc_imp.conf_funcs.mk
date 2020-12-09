.for n in 0 1 2 3 4 5 6 7 8 9

.for d in ${MKC_CHECK_FUNCS${n}:U} ${MKC_REQUIRE_FUNCS${n}:U}
var_suffix := ${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if !defined(HAVE_FUNC${n}.${var_suffix})
or_define := ${MKC_FUNC_OR_DEFINE.${d:C/:.*//}:tl:S/yes/ordefine/}
HAVE_FUNC${n}.${var_suffix}   !=   env ${mkc.environ} mkc_check_decl func${or_define}${n} ${d:S/:/ /g}
.  endif
.endfor

.for d in ${MKC_CHECK_FUNCS${n}}
var_suffix := ${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if ${HAVE_FUNC${n}.${var_suffix}}
MKC_CPPFLAGS  +=	-DHAVE_FUNC${n}_${d:C/:.*,/:/:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.  endif
.endfor # d

.for d in ${MKC_REQUIRE_FUNCS${n}:U}
var_suffix := ${d:C/:.*,/:/:S/./_/g:S/:/./g:S|/|_|g}
.  if !${HAVE_FUNC${n}.${var_suffix}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d func${n} ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of function ${d}"
.  endif
.endfor # d

MKC_CHECK_FUNCS${n}   := # workaround for buggy bmake-20110606
MKC_REQUIRE_FUNCS${n} := # workaround for buggy bmake-20110606

.undef MKC_CHECK_FUNCS${n}
.undef MKC_REQUIRE_FUNCS${n}

.endfor # n
