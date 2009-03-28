.include <_mkc.common.mk>

.if defined(MKC_NOBSDMK) && !empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
.include <files.mk>
.else
.include <bsd.files.mk>
.endif
