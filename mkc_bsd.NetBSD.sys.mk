# Setting specific to NetBSD

.if ${MACHINE_ARCH:U} == "sparc64" 
AFLAGS+= -Wa,-Av9a
.endif
