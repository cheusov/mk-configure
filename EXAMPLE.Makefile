MKC_CHECK_HEADERS+=	strings.h
MKC_CHECK_HEADERS+=	sys/time.h
MKC_CHECK_HEADERS+=	inttypes.h
MKC_CHECK_HEADERS+=	stdint.h
MKC_CHECK_HEADERS+=	zlib.h
MKC_CHECK_HEADERS+=	Judy.h

MKC_CHECK_FUNCLIBS+=	accept:socket
MKC_CHECK_FUNCLIBS+=	crypt:crypt
MKC_CHECK_FUNCLIBS+=	strlcat
MKC_CHECK_FUNCLIBS+=	strlcpy
MKC_CHECK_FUNCLIBS+=	dlopen
MKC_CHECK_FUNCLIBS+=	dlopen:dl
MKC_CHECK_FUNCLIBS+=	gethostbyname:nsl
MKC_CHECK_FUNCLIBS+=	nanosleep:rt
MKC_CHECK_FUNCLIBS+=	ftime:compat
MKC_CHECK_FUNCLIBS+=	gettimeofday
MKC_CHECK_FUNCLIBS+=	kvm_read:kvm

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

MKC_CHECK_SIZEOF+=	size_t:string.h

MKC_CHECK_SIZEOF+=	off_t:sys/types.h

.include <bsd.own.mk>
.include "configure.mk"

.if !${HAVE_HEADER.sys.time_h}
MKC_ERR_MSG+= "Really?"
.endif

.if !${HAVE_HEADER.zlib_h}
MKC_ERR_MSG+= "zlib.h not found, install it!"
.endif

.if !${HAVE_HEADER.Judy_h}
MKC_ERR_MSG+= "Judy.h not found, install it!"
.endif

.if !${HAVE_FUNCLIB.strlcpy}
SRCS+= strlcpy.c
.endif

.if !${HAVE_FUNCLIB.strlcat}
SRCS+= strlcat.c
.endif

.if ${HAVE_FUNCLIB.dlopen}
.elif ${HAVE_FUNCLIB.dlopen.dl}
LDADD+= -ldl
.else
SRCS+= dlopen.c
CFLAGS+= -DMY_OWN_DLOPEN
.endif

# your real code here

.include <bsd.prog.mk>
