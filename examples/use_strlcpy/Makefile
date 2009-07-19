MKC_SOURCE_FUNCLIBS=	strlcpy
MKC_CHECK_FUNCS3+=	strlcpy:string.h

PROG=			hello4
SRCS=			hello.c
MKMAN=			no

.PHONY : all
${.OBJDIR}/${.CURDIR:T}.test.out: all
	@set -e; \
	{ \
	${.OBJDIR}/hello4 < ${.CURDIR}/input.in; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	sed -e 's,${.OBJDIR},/objdir,' -e 's,${PREFIX},/prefix,'; \
	} > ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>
.include <mkc.prog.mk>
