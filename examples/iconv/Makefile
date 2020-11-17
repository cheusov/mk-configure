MKC_CHECK_PROTOTYPES =	posix_iconv const_iconv

MKC_PROTOTYPE_FUNC.posix_iconv = \
    size_t    iconv    (iconv_t,       char **, size_t *, char **, size_t *)
MKC_PROTOTYPE_FUNC.const_iconv = \
    size_t     iconv    (iconv_t, const char **, size_t *, char **, size_t *)

MKC_PROTOTYPE_HEADERS.posix_iconv = iconv.h
MKC_PROTOTYPE_HEADERS.const_iconv = iconv.h

PROG  =		hello_iconv

WARNS =		4

MKC_REQD =		0.26.0

.include "test.mk"
.include <mkc.prog.mk>
