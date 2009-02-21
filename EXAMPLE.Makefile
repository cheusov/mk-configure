MKC_HEADERS+=	strings.h
MKC_HEADERS+=	sys/time.h
MKC_HEADERS+=	inttypes.h
MKC_HEADERS+=	stdint.h
MKC_HEADERS+=	zlib.h
MKC_HEADERS+=	Judy.h

MKC_FUNCS+=	accept
MKC_FUNCS+=	accept|-lsocket
MKC_FUNCS+=	crypt|-lcrypt
MKC_FUNCS+=	strlcat
MKC_FUNCS+=	strlcpy
MKC_FUNCS+=	dlopen
MKC_FUNCS+=	dlopen|-ldl
MKC_FUNCS+=	gethostbyname
MKC_FUNCS+=	gethostbyname|-lnsl
MKC_FUNCS+=	nanosleep
MKC_FUNCS+=	nanosleep|-lrt

MKC_SIZEOF+=	float
MKC_SIZEOF+=	double
MKC_SIZEOF+=	short
MKC_SIZEOF+=	int
MKC_SIZEOF+=	long
MKC_SIZEOF+=	long-long # - means space
MKC_SIZEOF+=	void*

MKC_SIZEOF+=	size_t
MKC_SIZEOF_INCS.size_t = string.h

MKC_SIZEOF+=	off_t
MKC_SIZEOF_INCS.off_t = sys/types.h

.include "configure.mk"

.if !${HAVE.zlib.h}
ERR_MSG+= "zlib.h not found, install it!"
.endif

.if !${HAVE.Judy.h}
ERR_MSG+= "Judy.h not found, install it!"
.endif

.if !${HAVE.strlcpy}
SRCS+= strlcpy.c
.endif

.if !${HAVE.strlcat}
SRCS+= strlcat.c
.endif

.if !${HAVE.nanosleep} && ${HAVE.nanosleep_rt}
LDADD+= -lrt
.endif

.if ${HAVE.crypt_crypt}
LDADD+= -lcrypt
.endif

.if ${HAVE.gethostbyname}
.elif ${HAVE.gethostbyname_nsl}
LDADD+= -lnsl
.else
ERR_MSG+= "Not UNIX :-P"
.endif

.if ${HAVE.dlopen}
.elif ${HAVE.dlopen_dl}
LDADD+= -ldl
.else
SRCS+= dlopen.c
CFLAGS+= -DMY_OWN_DLOPEN
.endif

.if ${HAVE.accept}
.elif ${HAVE.accept_socket}
LDADD+= -lsocket
.else
ERR_MSG+= "Not UNIX :-P"
.endif

# your real code here

.include <bsd.prog.mk>
