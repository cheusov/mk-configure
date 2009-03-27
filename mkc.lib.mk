.include <_mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.lib.mk>
.else
.include <lib.mk>
.endif
