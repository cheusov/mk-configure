.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/sizeof_test | tr '1248' 'nnnn'; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
