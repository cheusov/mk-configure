VERSION   =		0.33.91

BIRTHDATE =		2009-02-21

MKFILESDIR     =	${PREFIX}/share/mk-configure/mk       # = overrides newsys.mk.in
DOCDIR        ?=	${PREFIX}/share/doc/mk-configure
BUILTINSDIR    =	${PREFIX}/share/mk-configure/builtins # = overrides newsys.mk.in
FEATURESDIR    =	${PREFIX}/share/mk-configure/features # = overrides newsys.mk.in

INTEXTS_REPLS +=	version        ${VERSION}
INTEXTS_REPLS +=	AWK            ${USE_AWK:U}
INTEXTS_REPLS +=	SH             ${USE_SH:U}
INTEXTS_REPLS +=	BMAKE          ${BMAKE}
INTEXTS_REPLS +=	mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS +=	syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS +=	mkc_libexecdir ${LIBEXECDIR}/mk-configure

.if !make(clean) && !make(cleandir)
.  if empty(USE_AWK) || ${USE_AWK} == "auto"
USE_AWK=
.     if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
USE_AWK        =	/usr/xpg4/bin/awk
.     endif
.     if ${USE_AWK:U} == ""
USE_AWK       !=	${.CURDIR}/scripts/mkc_which.in gawk 2>/dev/null || true
.     endif
.     if ${USE_AWK:U} == ""
USE_AWK       !=	${.CURDIR}/scripts/mkc_which.in nawk 2>/dev/null || true
.     endif
.     if ${USE_AWK:U} == ""
USE_AWK       !=	${.CURDIR}/scripts/mkc_which.in awk 2>/dev/null || true
.     endif
.     if ${USE_AWK:U} == ""
.        error "Cannot find AWK"
.     endif
.  endif # empty(USE_AWK) ...
.  export USE_AWK

.  if empty(USE_SH) || ${USE_SH} == "auto"
USE_SH=
.     if exists(/usr/xpg4/bin/sh)
# Solaris-10's /bin/sh is completely broken,
# /usr/xpg4/bin/sh sucks too but sucks less.
USE_SH        =	/usr/xpg4/bin/sh
.     else
USE_SH        = /bin/sh
.     endif
.  endif # empty(USE_SH)...
.  export USE_SH
.endif # !make(clean) ...

BMAKE  ?=	bmake
PS2PDF ?=	ps2pdf
DOT    ?=	dot
DVIPS  ?=	dvips
LATEX  ?=	latex

generated_scripts =	mkc_check_prog mkc_which mkc_check_custom

DIST_TARGETS =		pdf clean-mk clean-scripts mkc_clean
