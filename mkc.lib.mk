.include <_mkc.common.mk>

.if defined(MKC_NOBSDMK) && !empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
.include <lib.mk>
.else
.include <bsd.lib.mk>
.endif
