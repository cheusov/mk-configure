MKC_REQUIRE_prog_gawk=1
MKC_REQUIRE_prog_flex=1
MKC_REQUIRE_prog_gm4=1
MKC_REQUIRE_prog_bison=1

SCRIPTS=	fake

test: error-check
	@echo ${HAVE_CUSTOM.prog_gawk}
	@echo ${HAVE_CUSTOM.prog_gm4}
	@echo ${HAVE_CUSTOM.prog_flex}
	@echo ${HAVE_CUSTOM.prog_bison}

.include <mkc.prog.mk>
