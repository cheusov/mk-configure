CLEANDIRS    +=	${.CURDIR}/usr ${.CURDIR}/opt

.ifdef SRCDIR_builtins
# regression test for mk-configure
MKC_CACHEDIR  =	${.CURDIR}
BUILTINSDIR   =	${SRCDIR_builtins}
FEATURESDIR   =	${SRCDIR_features}
SHRTOUT       =	no
.export MKC_CACHEDIR BUILTINSDIR FEATURESDIR SHRTOUT
.endif
