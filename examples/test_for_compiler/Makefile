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
${.OBJDIR}/${.CURDIR:T}.test.out: all
	@set -e; \
	{ \
	${.OBJDIR}/compiler_test; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	sed -e 's,${.OBJDIR},/objdir,' -e 's,${PREFIX},/prefix,'; \
	} > ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
