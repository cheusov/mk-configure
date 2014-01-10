# this is a backward compatibility test for endianess (single n)

MKC_CHECK_BUILTINS +=		endianess

MKC_REQD =		0.12.0

.include <mkc.configure.mk>

.PHONY: showme
showme:
	@echo BUILTIN.endianess=${BUILTIN.endianess}

.include "test.mk"
.include <mkc.prog.mk>
