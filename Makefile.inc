VERSION   =		0.29.2

BIRTHDATE =		2009-02-21

MKFILESDIR    ?=	${PREFIX}/share/mkc-mk
DOCDIR        ?=	${PREFIX}/share/doc/mk-configure
BUILTINSDIR   ?=	${PREFIX}/share/mk-configure/builtins
FEATURESDIR   ?=	${PREFIX}/share/mk-configure/features

INTEXTS_REPLS +=	version        ${VERSION}
INTEXTS_REPLS +=	AWK            ${PROG.awk}
INTEXTS_REPLS +=	BMAKE          ${BMAKE}
INTEXTS_REPLS +=	mkfilesdir     ${MKFILESDIR}
INTEXTS_REPLS +=	syscustomdir   ${BUILTINSDIR}
INTEXTS_REPLS +=	mkc_libexecdir ${LIBEXECDIR}/mk-configure

.if exists(/usr/xpg4/bin/awk)
# Solaris' /usr/bin/awk is completely broken,
# /usr/xpg4/bin/awk sucks too but sucks less.
PROG.awk ?=		/usr/xpg4/bin/awk
.else
MKC_REQUIRE_PROGS +=	awk
.endif

MKC_CACHEDIR =	${.CURDIR}/..
#.export MKC_CACHEDIR

BMAKE  ?=	bmake
PS2PDF ?=	ps2pdf
DOT    ?=	dot
DVIPS  ?=	dvips
LATEX  ?=	latex

generated_scripts =	mkc_check_prog mkc_which mkc_check_custom
