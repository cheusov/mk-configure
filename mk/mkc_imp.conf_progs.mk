.for p in ${MKC_CHECK_PROGS} ${MKC_REQUIRE_PROGS}
p_      :=	${p}
prog_id :=	${MKC_PROG.id.${p:S|+|x|g}:U${p}:S|/|_|g}
.  ifdef PROG.${prog_id}
.  elif !empty(p_:M/*)
PROG.${prog_id} = ${p}
.  else
PROG.${prog_id} != env ${mkc.environ} mkc_check_prog -i '${prog_id}' '${p}'
.  endif # !defined(PROG.${prog_id})
.  ifndef HAVE_PROG.${prog_id}
.    if !empty(PROG.${prog_id}) && exists(${PROG.${prog_id}})
HAVE_PROG.${prog_id} =		1
.    else
HAVE_PROG.${prog_id} =		0
.    endif
.  endif # ifndef HAVE_PROG.${prog_id}

.  if defined(MKC_REQUIRE_PROGS) && !${HAVE_PROG.${prog_id}} && !empty(MKC_REQUIRE_PROGS:U1:M${p})
_fake   !=   env ${mkc.environ} mkc_check_prog -d -i '${prog_id}' '${p}' && echo
MKC_ERR_MSG +=	"ERROR: cannot find program ${p}"
.  endif
.endfor # p

.undef MKC_CHECK_PROGS
.undef MKC_REQUIRE_PROGS
