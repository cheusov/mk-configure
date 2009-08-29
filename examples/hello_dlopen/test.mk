.PHONY : test_output all
test_output: all
	@set -e; LC_ALL=C; export LC_ALL; \
	${.OBJDIR}/dlopen_test | \
	sed -e 's/0x//' -e 's/[0-9a-fA-F]*$$/F00DBEAF/'; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
