.include <mkc.configure.mk>

.if ${CC_TYPE:U} == "sunpro"
MKC_CHECK_CC_OPTS += -erroff=E_STATEMENT_NOT_REACHED
.include <mkc.configure.mk>
.if ${HAVE_CC_OPT.-erroff_E_STATEMENT_NOT_REACHED:U0}
CFLAGS += -erroff=E_STATEMENT_NOT_REACHED
.endif
.endif
