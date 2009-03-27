.include <_mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.man.mk>
.else
.include <man.mk>
.endif
