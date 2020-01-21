VERSION   =		0.33.0

BIRTHDATE =		2009-02-21

MKFILESDIR    ?=	${PREFIX}/share/mkc-mk
DOCDIR        ?=	${PREFIX}/share/doc/mk-configure
BUILTINSDIR   ?=	${PREFIX}/share/mk-configure/builtins
FEATURESDIR   ?=	${PREFIX}/share/mk-configure/features

INTEXTS_REPLS +=	version        ${VERSION}
INTEXTS_REPLS +=	AWK            ${MKC_AWK}
INTEXTS_REPLS +=	SH             ${MKC_SH}
INTEXTS_REPLS +=	BMAKE          ${BMAKE}
INTEXTS_REPLS +=	mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS +=	syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS +=	mkc_libexecdir ${LIBEXECDIR}/mk-configure

.ifndef MKC_AWK
.  if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
MKC_AWK        =	/usr/xpg4/bin/awk
.  endif
.  if ${MKC_AWK:U} == ""
MKC_AWK       !=	${.CURDIR}/scripts/mkc_which.in gawk 2>/dev/null || true
.  endif
.  if ${MKC_AWK:U} == ""
MKC_AWK       !=	${.CURDIR}/scripts/mkc_which.in nawk 2>/dev/null || true
.  endif
.  if ${MKC_AWK:U} == ""
MKC_AWK       !=	${.CURDIR}/scripts/mkc_which.in awk 2>/dev/null || true
.  endif
.  if ${MKC_AWK:U} == ""
.    error "Cannot find AWK"
.  endif
.export MKC_AWK
.endif

.ifndef MKC_SH
.  if exists(/usr/xpg4/bin/sh)
# Solaris-10's /bin/sh is completely broken,
# /usr/xpg4/bin/sh sucks too but sucks less.
MKC_SH        =	/usr/xpg4/bin/sh
.  else
MKC_SH        = /bin/sh
.  endif
.endif

#MKC_CACHEDIR =	${.CURDIR}/..
#.export MKC_CACHEDIR

BMAKE  ?=	bmake
PS2PDF ?=	ps2pdf
DOT    ?=	dot
DVIPS  ?=	dvips
LATEX  ?=	latex

generated_scripts =	mkc_check_prog mkc_which mkc_check_custom

DIST_TARGETS =		pdf clean-mk clean-scripts mkc_clean
