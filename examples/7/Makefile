MKC_CHECK_DEFINES+=	__INTEL_COMPILER __GNUC__ _MSC_VER __PCC__

PROG=			compiler_test

MKMAN=			no

.include <mkc.configure.mk>

.if ${HAVE_DEFINE._MSC_VER}
msg=	Microsoft C Compiler
.elif ${HAVE_DEFINE.__INTEL_COMPILER}
msg=	Intel C Compiler
.elif ${HAVE_DEFINE.__PCC__}
msg=	Portable C Compiler
.elif ${HAVE_DEFINE.__GNUC__}
msg=	GNU C Compiler
.else
msg=	Unknown compiler
.endif

CFLAGS+=	-DMSG='"${msg}"'

aaa:
	@echo HAVE_DEFINE._MSC_VER=${HAVE_DEFINE._MSC_VER}
	@echo HAVE_DEFINE.__INTEL_COMPILER=${HAVE_DEFINE.__INTEL_COMPILER}
	@echo HAVE_DEFINE.__PCC__=${HAVE_DEFINE.__PCC__}
	@echo HAVE_DEFINE.__GNUC__=${HAVE_DEFINE.__GNUC__}

.include <mkc.prog.mk>
