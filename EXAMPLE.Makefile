MKC_CHECK_HEADERS+=	sys/time.h
MKC_CHECK_HEADERS+=	inttypes.h
MKC_CHECK_HEADERS+=	stdint.h
MKC_CHECK_HEADERS+=	zlib.h

#MKC_FUNCLIBS_NOAUTO=	1 # in order to disable automatic updates of LDADD
MKC_CHECK_FUNCLIBS+=	crypt:crypt
MKC_CHECK_FUNCLIBS+=	strlcat
MKC_CHECK_FUNCLIBS+=	dlopen:dl
MKC_CHECK_FUNCLIBS+=	ftime:compat
MKC_FUNCLIBS_NOAUTO.ftime.compat = 1
MKC_CHECK_FUNCLIBS+=	gettimeofday

MKC_CHECK_DEFINES+=	RTLD_LAZY:dlfcn.h
MKC_CHECK_DEFINES+=	O_DIRECT:fcntl.h

MKC_CHECK_VARS+=	sys_errlist:errno.h
MKC_CHECK_FUNCS1+=	strerror:string.h

MKC_CHECK_FUNCS2+=	fgetln:stdio.h
MKC_CHECK_FUNCS3+=	getline:stdio.h

MKC_CHECK_FUNCS6+=	pselect:sys/select.h

MKC_CHECK_SIZEOF+=	int
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
MKC_ERR_MSG+= "zlib.h not found, install zlib library!"
.endif

.if ${HAVE_FUNCLIB.gettimeofday}
CFLAGS+=	-DUSE_GETTIMEOFDAY
.elif ${HAVE_FUNCLIB.ftime}
CFLAGS+=	-DUSE_FTIME
.elif ${HAVE_FUNCLIB.ftime.compat}
CFLAGS+=	-DUSE_FTIME
LDADD+=		-lcompat
.endif

.if !${HAVE_FUNCLIB.strlcat}
SRCS+= strlcat.c
.endif

.if ${HAVE_FUNCLIB.dlopen} || ${HAVE_FUNCLIB.dlopen.dl}
CFLAGS+=	-DPLUGINS_ENABLED=1
.else
CFLAGS+=	-DPLUGINS_ENABLED=0
.endif

.if ${HAVE_DEFINE.RTLD_LAZY.dlfcn_h}
.for n in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
.if exists(/lib/libc.so.${n})
LIBC_SO_FN=	/lib/libc.so.${n}
.endif
.endfor
CFLAGS+=	-DLIBC_SO='"${LIBC_SO_FN}"'
.endif

# your real code here

.include <bsd.prog.mk>
