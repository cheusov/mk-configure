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
command += printf "MKC_PROTOTYPE_FUNC.proto=void proto(void)\n" ${t} > ${.OBJDIR}/test.mk;
command += printf "MKC_PROTOTYPE_HEADERS.proto=err.h\n" ${t} >> ${.OBJDIR}/test.mk;
command += printf "%s\n.include <mkc.mk>\n" ${t} >> ${.OBJDIR}/test.mk;
command += ${MAKE} -f ${.OBJDIR}/test.mk ${MAKEFLAGS} all 2>&1 || true;
.endfor

.PHONY : test_output
test_output:
	@set -e; \
	echo =========== all ============; \
	{ ${command} } | grep ERROR:; \
	true _______ cleandir _______ %%; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
.include <mkc.mk>
