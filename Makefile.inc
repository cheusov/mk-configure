VERSION   =		0.25.0

BIRTHDATE =		2009-02-21

MKFILESDIR    ?=	${PREFIX}/share/mkc-mk
DOCDIR        ?=	${PREFIX}/share/doc/mk-configure
BUILTINSDIR   ?=	${PREFIX}/share/mk-configure/custom

INTEXTS_REPLS +=	version        ${VERSION}
INTEXTS_REPLS +=	AWK            ${AWK}
INTEXTS_REPLS +=	BMAKE          ${BMAKE}
INTEXTS_REPLS +=	mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS +=	syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS +=	mkc_libexecdir ${LIBEXECDIR}

.if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
AWK ?=			/usr/xpg4/bin/awk
.elif exists(/usr/bin/awk)
AWK ?=			/usr/bin/awk
.else
AWK ?=			/bin/awk
.endif

BMAKE  ?=	bmake
PS2PDF ?=	ps2pdf
DOT    ?=	dot
DVIPS  ?=	dvips
LATEX  ?=	latex
