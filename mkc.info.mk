.include <mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.info.mk>
.else
.include <info.mk>
.endif
