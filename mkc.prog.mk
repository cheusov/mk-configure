.include <_mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.prog.mk>
.else
.include <prog.mk>
.endif
