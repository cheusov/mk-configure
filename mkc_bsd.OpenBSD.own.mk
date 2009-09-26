.if ${MACHINE_ARCH} == "alpha" || \
     ${MACHINE_ARCH} == "powerpc" || \
     ${MACHINE_ARCH} == "sparc" || \
    ( ${MACHINE_ARCH} == "i386" && ${OS_VERSION} >= 3.4 )
OBJECT_FMT?=ELF
.else
OBJECT_FMT?=a.out
.endif
