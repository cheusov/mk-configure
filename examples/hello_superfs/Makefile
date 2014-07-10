SUBPRJ =	docs mkfs_superfs:tools fsck_superfs:tools

SUBPRJ_DFLT =	mkfs_superfs fsck_superfs docs

# "tools" is a virtual subproject, there is no subdirectory for it

TMPPREFIX   =	${.OBJDIR}/tmp
.export TMPPREFIX

.include "test.mk"
.include <mkc.subprj.mk>
