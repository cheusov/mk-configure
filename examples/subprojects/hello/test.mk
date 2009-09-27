.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/hello_subprojects2; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; MKHTML=no; export MKCATPAGES MKHTML; \
	${MAKE} ${MAKE_FLAGS} installdirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	sed -e 's,${.OBJDIR},/objdir,' -e 's,${PREFIX},/prefix,'

.include <mkc.minitest.mk>
