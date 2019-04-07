# this is a backward compatibility test for endianess (single n)

MKC_CHECK_BUILTINS +=		endianness

MKC_REQD =		0.12.0

.include <mkc.configure.mk>

.PHONY: showme
showme:
	@echo BUILTIN.endianness=${BUILTIN.endianness}

.include "test.mk"
.include <mkc.prog.mk>
