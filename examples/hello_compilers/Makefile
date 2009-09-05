MKC_CHECK_DEFINES+=	__INTEL_COMPILER __GNUC__ _MSC_VER __PCC__

PROG=			compiler_test

MKC_REQD=		0.10.0

.include <mkc.configure.mk>

.if ${HAVE_DEFINE._MSC_VER:U0}
msg=	Microsoft C Compiler
.elif ${HAVE_DEFINE.__INTEL_COMPILER:U0}
msg=	Intel C Compiler
.elif ${HAVE_DEFINE.__PCC__:U0}
msg=	Portable C Compiler
.elif ${HAVE_DEFINE.__GNUC__:U1}
msg=	GNU C Compiler
.else
msg=	Unknown compiler
.endif

CFLAGS+=	-DMSG='"${msg}"'

.include "test.mk"
.include <mkc.prog.mk>
