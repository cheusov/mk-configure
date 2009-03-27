.include <mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.files.mk>
.else
.include <files.mk>
.endif
