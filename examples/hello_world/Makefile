PROG=	hello_world

MKMAN=	no

.PHONY : all
${.OBJDIR}/${.CURDIR:T}.test.out: all
	@set -e; \
	{ \
	${.OBJDIR}/hello_world; \
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
