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

.PHONY : all
test.out: all
	@./compiler_test > ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
