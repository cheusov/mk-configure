.for i in ${FILES}
SCRIPTS+=	${i}
SCRIPTSDIR=	${BINDIR}
.if defined(FILESDIR_${i})
SCRIPTSDIR_${i}=${FILESDIR_${i}}
.else
SCRIPTSDIR_${i}=${FILESDIR}
.endif

MODE_${i}=${FILESMODE_${i}:U${FILESMODE}:U${NONBINMODE}}
OWN_${i}=${FILESOWN_${i}:U${FILESOWN}}
GRP_${i}=${FILESGRP_${i}:U${FILESGRP}}

.endfor
