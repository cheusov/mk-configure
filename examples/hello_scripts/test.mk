.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/hello_world1; \
	${.CURDIR}/hello_world2; \
	${.CURDIR}/hello_world3; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; MKHTML=no; export MKCATPAGES MKHTML; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
