MKC_CHECK_SIZEOF+=	int long long-long size_t:string.h void*

PROG=			sizeof_test

MKMAN=			no

.PHONY : all
${.OBJDIR}/${.CURDIR:T}.test.out: all
	@set -e; \
	{ \
	${.OBJDIR}/sizeof_test | tr '1248' 'nnnn'; \
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
