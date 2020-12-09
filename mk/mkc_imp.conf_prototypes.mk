.for p in ${MKC_CHECK_PROTOTYPES} ${MKC_REQUIRE_PROTOTYPES}
.  if !defined(HAVE_PROTOTYPE.${p})
HAVE_PROTOTYPE.${p} !=	env ${mkc.environ} mkc_check_decl prototype \
	${MKC_PROTOTYPE_FUNC.${p}:Q} ${MKC_PROTOTYPE_HEADERS.${p}}
.  endif # !defined(HAVE_PROTOTYPE.${p})
.  if ${HAVE_PROTOTYPE.${p}}
MKC_CPPFLAGS  +=	-DHAVE_PROTOTYPE_${p:tu}=1
.  elif !empty(MKC_REQUIRE_PROTOTYPES:U:M${p})
_fake       !=	env ${mkc.environ} mkc_check_decl -d prototype \
	${MKC_PROTOTYPE_FUNC.${p}:Q} ${MKC_PROTOTYPE_HEADERS.${p}}; echo
MKC_ERR_MSG +=		"ERROR: prototype test ${p} failed"
.  endif # ${PROTOTYPE.${p}}
.endfor # p

.undef MKC_CHECK_PROTOTYPES
.undef MKC_REQUIRE_PROTOTYPES
