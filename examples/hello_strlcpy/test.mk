.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/hello4 < ${.CURDIR}/input.in; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
