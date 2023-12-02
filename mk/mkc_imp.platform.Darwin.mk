SHLIB_EXT.Darwin =	.dylib
DLL_EXT.Darwin   =	.bundle
LD_TYPE.Darwin   =	darwinld

.if ${MKDLL:U} == "no"
LDFLAGS.shared.gcc.Darwin  =	-dynamiclib -install_name ${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
LDFLAGS.shared.clang.Darwin  =	-dynamiclib -install_name ${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
SHLIB_MAJORp1 !=		expr 1 + ${SHLIB_MAJOR:U0}
LDFLAGS.soname.gcc =		-current_version ${SHLIB_MAJORp1}${SHLIB_MINOR:D.${SHLIB_MINOR}}${SHLIB_TEENY:D.${SHLIB_TEENY}}
LDFLAGS.soname.gcc +=		-compatibility_version ${SHLIB_MAJORp1}
.else
LDFLAGS.shared.gcc.Darwin =	-flat_namespace -bundle -undefined suppress
LDFLAGS.shared.clang.Darwin =	-flat_namespace -bundle -undefined suppress
.endif

.if ${MKDLL:U} != "no"

SHLIB_EXTFULL  ?=	.bundle

.else # MKDLL

.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1 ?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2 ?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3 ?=	.${SHLIB_FULLVERSION}.dylib
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}.${SHLIB_TEENY}
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}.${SHLIB_MINOR}
.endif # SHLIB_TEENY
.else
SHLIB_FULLVERSION = ${SHLIB_MAJOR}
.endif # SHLIB_MINOR
.endif # SHLIB_MAJOR

SHLIB_EXTFULL ?=	.${SHLIB_FULLVERSION}.dylib
.endif
