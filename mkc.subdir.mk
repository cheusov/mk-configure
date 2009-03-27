.include <_mkc.common.mk>

.if !defined(NOMKCBSD) || empty(NOMKCBSD:M[Yy][Ee][Ss])
.include <bsd.subdir.mk>
.else
.include <subdir.mk>
.endif
