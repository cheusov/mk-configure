SUBPRJ =	docs mkfs_superfs:tools fsck_superfs:tools

SUBPRJ_DFLT =	tools docs

# "tools" is a virtual subproject, there is no subdirectory for it

TMPPREFIX   =	${.OBJDIR}/tmp
.export TMPPREFIX

HELP_MSG.mkfs_superfs = "Creates super file system"
HELP_MSG.fsck_superfs = "Checks super file system"
HELP_MSG.docs         = "Documentation files"
HELP_MSG.tools        = "mkfs_superfs and fsck_superfs"

.include "test.mk"
.include <mkc.subprj.mk>
