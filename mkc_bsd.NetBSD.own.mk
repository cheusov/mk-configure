# The sh3 port is incomplete.
.if ${MACHINE_ARCH} == "sh3eb" || ${MACHINE_ARCH} == "sh3el"
NOLINT=1
NOPROFILE=1
OBJECT_FMT?=COFF
NOPIC?=1
.endif

# The sparc64 port is incomplete.
# Profiling and linting is also off on the x86_64 port at the moment.
.if ${MACHINE_ARCH} == "sparc64" || ${MACHINE_ARCH} == "x86_64"
NOPROFILE=1
NOLINT=1
.endif

# The m68000 port is incomplete.
.if ${MACHINE_ARCH} == "m68000"
NOLINT=1
NOPROFILE=1
NOPIC?=1
.endif

# Data-driven table using make variables to control how 
# toolchain-dependent targets and shared libraries are built
# for different platforms and object formats.
# OBJECT_FMT:		currently either "ELF" or "a.out".
# SHLIB_TYPE:		"ELF" or "a.out" or "" to force static libraries.
#
.if ${MACHINE_ARCH} == "alpha" || \
    ${MACHINE_ARCH} == "mipsel" || ${MACHINE_ARCH} == "mipseb" || \
    ${MACHINE_ARCH} == "powerpc" || \
    ${MACHINE_ARCH} == "sparc" || \
    ${MACHINE_ARCH} == "sparc64" || \
    ${MACHINE_ARCH} == "x86_64" || \
    ${MACHINE_ARCH} == "i386" || \
    ${MACHINE_ARCH} == "m68000" || \
    ${MACHINE_ARCH} == "arm" || \
    ${MACHINE} == "next68k" || \
    ${MACHINE} == "sun3" || \
    ${MACHINE} == "mvme68k" || \
    ${MACHINE} == "hp300" || \
    ${MACHINE} == "news68k" || \
    ${MACHINE} == "arm26"
OBJECT_FMT?=ELF
.else
OBJECT_FMT?=a.out
.endif

.if ${CC:M*gcc*} != ""
.if ${MACHINE_ARCH} == "x86_64"
CFLAGS+=-Wno-format -fno-builtin
.endif
.endif

# CPU model, derived from MACHINE_ARCH
MACHINE_CPU=	${MACHINE_ARCH:C/mipse[bl]/mips/:S/arm26/arm/:S/arm32/arm/:C/sh3e[bl]/sh3/:S/m68000/m68k/}

.if ${MACHINE_ARCH} == "mips"
.BEGIN:
	@echo Must set MACHINE_ARCH to one of mipseb or mipsel
	@false
.endif
.if ${MACHINE_ARCH} == "sh3"
.BEGIN:
	@echo Must set MACHINE_ARCH to one of sh3eb or sh3el
	@false
.endif

