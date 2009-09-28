######################################################################
.if ${OPSYS} == "NetBSD"

#
# The ia64 port is incomplete.
#
.if ${MACHINE_ARCH} == "ia64"
MKLINT=         no
MKGDB=          no
.endif

#
# On the MIPS, all libs are compiled with ABIcalls (and are thus PIC),
# not just shared libraries, so don't build the _pic version.
#
.if ${MACHINE_ARCH} == "mipsel" || ${MACHINE_ARCH} == "mipseb"
MKPICLIB:=      no
.endif

#
# On VAX using ELF, all objects are PIC, not just shared libraries,
# so don't build the _pic version.  Unless we are using GCC3 which
# doesn't support PIC yet.
#
.if ${MACHINE_ARCH} == "vax"
MKPICLIB=       no
.endif

#
#
#
.if ${MACHINE_ARCH} == "mips" || ${MACHINE_ARCH} == "mips64" || \
    ${MACHINE_ARCH} == "sh3"
.BEGIN:
        @echo "Must set MACHINE_ARCH to one of ${MACHINE_ARCH}eb or ${MACHINE_ARCH}el"
        @false
.endif

######################################################################
.elif ${OPSYS} == "OpenBSD"

.if ${MACHINE_ARCH} == "alpha" || \
     ${MACHINE_ARCH} == "powerpc" || \
     ${MACHINE_ARCH} == "sparc" || \
    ( ${MACHINE_ARCH} == "i386" && ${OS_VERSION} >= 3.4 )
OBJECT_FMT?=ELF
.else
OBJECT_FMT?=a.out
.endif

######################################################################
.endif
