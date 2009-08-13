.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/dlopen_test libc.so | sed 's/0x......../0xF00DBEAF/'; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	sed -e 's,${.OBJDIR},/objdir,' -e 's,${PREFIX},/prefix,'

.include <mkc.minitest.mk>
