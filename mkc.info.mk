.include <_mkc.common.mk>

.if defined(MKC_NOBSDMK) && !empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
.include <info.mk>
.else
.include <bsd.info.mk>
.endif
