PROG=		hello_world1
SRCS=		main.c msg.c

SCRIPTS=	hello_world2 hello_world3

MAN=		hello_world.1

.PHONY : test_output all
test_output: all
	@set -e; \
	${.OBJDIR}/hello_world1; \
	${.CURDIR}/hello_world2; \
	${.CURDIR}/hello_world3; \
	echo ============================; \
	rm -rf ${.OBJDIR}${PREFIX}; \
	MKCATPAGES=no; export MKCATPAGES; \
	${MAKE} ${MAKE_FLAGS} install-dirs install DESTDIR=${.OBJDIR} \
		> /dev/null; \
	find ${.OBJDIR}${PREFIX} -type f | \
	sed -e 's,${.OBJDIR},/objdir,' -e 's,${PREFIX},/prefix,'

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
