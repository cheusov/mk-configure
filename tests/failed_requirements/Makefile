CLEANFILES += test.mk

tests = \
	MKC_REQUIRE_HEADER_FILES=bad_header.h \
	MKC_REQUIRE_HEADERS=bad_header.h \
	MKC_REQUIRE_FUNCLIBS=bad_func \
	MKC_REQUIRE_DEFINES=ZZZZ:string.h \
	MKC_REQUIRE_TYPES=zzzz_t:sys/cdefs.h \
	MKC_REQUIRE_VARS=zzzz:string.h \
	MKC_REQUIRE_MEMBERS=struct-stat.st_atimespec:foo.h \
	MKC_REQUIRE_FUNCS9=zzzz:unistd.h \
	MKC_REQUIRE_PROGS=zzz_tool \
	MKC_REQUIRE_PROTOTYPES=proto

.for t in ${tests}
command += printf "MKC_PROTOTYPE_FUNC.proto=void proto(void)\n" > ${.OBJDIR}/test.mk;
command += printf "MKC_PROTOTYPE_HEADERS.proto=err.h\n" >> ${.OBJDIR}/test.mk;
command += printf "${t}\n" >> ${.OBJDIR}/test.mk;
command += printf ".include <mkc.mk>\n" >> ${.OBJDIR}/test.mk;
command += ${MAKE} -f ${.OBJDIR}/test.mk all 2>&1 || true;
.endfor

.PHONY : test_output
test_output:
	@set -e; \
	echo =========== all ============; \
	{ ${command} } | grep ERROR:; \
	true _______ cleandir _______ %%; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
.include <mkc.mk>
