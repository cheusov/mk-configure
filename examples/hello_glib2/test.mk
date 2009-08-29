.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/hello_glib2 | sed 's,[0-9][0-9]*,N,'; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	test_helper "${PREFIX}" "${.OBJDIR}"

.include <mkc.minitest.mk>
