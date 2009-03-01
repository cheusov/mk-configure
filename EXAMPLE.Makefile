MKC_CHECK_HEADERS+=	strings.h
MKC_CHECK_HEADERS+=	sys/time.h
MKC_CHECK_HEADERS+=	inttypes.h
MKC_CHECK_HEADERS+=	stdint.h
MKC_CHECK_HEADERS+=	zlib.h
MKC_CHECK_HEADERS+=	Judy.h

MKC_CHECK_FUNCS+=	accept
MKC_CHECK_FUNCS+=	accept:socket
MKC_CHECK_FUNCS+=	crypt:crypt
MKC_CHECK_FUNCS+=	strlcat
MKC_CHECK_FUNCS+=	strlcpy
MKC_CHECK_FUNCS+=	dlopen
MKC_CHECK_FUNCS+=	dlopen:dl
MKC_CHECK_FUNCS+=	gethostbyname
MKC_CHECK_FUNCS+=	gethostbyname:nsl
MKC_CHECK_FUNCS+=	nanosleep
MKC_CHECK_FUNCS+=	nanosleep:rt

MKC_CHECK_DEFINES+=	RTLD_LAZY:dlfcn.h
MKC_CHECK_DEFINES+=	O_DIRECT:fcntl.h

MKC_CHECK_VARS+=	sys_errlist:errno.h

MKC_CHECK_FUNCS1+=	strerror:string.h

MKC_CHECK_SIZEOF+=	float
MKC_CHECK_SIZEOF+=	double
MKC_CHECK_SIZEOF+=	short
MKC_CHECK_SIZEOF+=	int
MKC_CHECK_SIZEOF+=	long
MKC_CHECK_SIZEOF+=	long-long # - means space
MKC_CHECK_SIZEOF+=	void*

MKC_CHECK_SIZEOF+=	size_t
MKC_CHECK_SIZEOF_INCS.size_t = string.h

MKC_CHECK_SIZEOF+=	off_t
MKC_CHECK_SIZEOF_INCS.off_t = sys/types.h

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

.if ${HAVE.nanosleep.rt} && !${HAVE.nanosleep}
LDADD+= -lrt
.endif

.if ${HAVE.crypt.crypt}
LDADD+= -lcrypt
.endif

.if ${HAVE.gethostbyname}
.elif ${HAVE.gethostbyname.nsl}
LDADD+= -lnsl
.else
ERR_MSG+= "Not UNIX :-P"
.endif

.if ${HAVE.dlopen}
.elif ${HAVE.dlopen.dl}
LDADD+= -ldl
.else
SRCS+= dlopen.c
CFLAGS+= -DMY_OWN_DLOPEN
.endif

.if ${HAVE.accept}
.elif ${HAVE.accept.socket}
LDADD+= -lsocket
.else
ERR_MSG+= "Not UNIX :-P"
.endif

# your real code here

.include <bsd.prog.mk>
