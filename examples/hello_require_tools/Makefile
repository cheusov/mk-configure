MKC_REQUIRE_gawk=1
MKC_REQUIRE_flex=1
MKC_REQUIRE_gm4=1
MKC_REQUIRE_bison=1

SCRIPTS=	fake

test: error-check
	@echo ${HAVE_CUSTOM.gawk}
	@echo ${HAVE_CUSTOM.gm4}
	@echo ${HAVE_CUSTOM.flex}
	@echo ${HAVE_CUSTOM.bison}

.include <mkc.prog.mk>
