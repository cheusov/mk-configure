MKC_REQUIRE_prog_gawk=1
MKC_REQUIRE_prog_flex=1
MKC_REQUIRE_prog_gm4=1
MKC_REQUIRE_prog_bison=1

SCRIPTS=	fake

test: error-check
	@echo ${CUSTOM.prog_gawk}
	@echo ${CUSTOM.prog_gm4}
	@echo ${CUSTOM.prog_flex}
	@echo ${CUSTOM.prog_bison}

.include <mkc.prog.mk>
