#	$NetBSD: bsd.prog.mk,v 1.1.1.1 2006/07/14 23:13:01 jlam Exp $
#	@(#)bsd.prog.mk	8.2 (Berkeley) 4/2/94

.if !defined(_MKC_BSD_PROG_MK)
_MKC_BSD_PROG_MK=1

.include <mkc_bsd.init.mk>

.PHONY:		proginstall scriptsinstall
realinstall:	proginstall scriptsinstall
clean cleandir:

CFLAGS+=	${COPTS}

# here is where you can define what LIB* are
.-include <libnames.mk>

.if defined(PROG)
SRCS?=		${PROG}.c

DPSRCS+=	${SRCS:M*.l:.l=.c} ${SRCS:M*.y:.y=.c}
CLEANFILES+=	${DPSRCS}
.if defined(YHEADER)
CLEANFILES+=	${SRCS:M*.y:.y=.h}
.endif

.if !empty(SRCS:N*.h:N*.sh:N*.fth)
OBJS+=		${SRCS:N*.h:N*.sh:N*.fth:R:S/$/.o/g}
LOBJS+=		${LSRCS:.c=.ln} ${SRCS:M*.c:.c=.ln}
.endif

.if defined(OBJS) && !empty(OBJS)
.NOPATH: ${OBJS}

${PROG}: ${LIBCRT0} ${DPSRCS} ${OBJS} ${LIBC} ${LIBCRTBEGIN} ${LIBCRTEND} ${DPADD}
.if !commands(${PROG})
	${CC} ${LDFLAGS} ${LDSTATIC} -o ${.TARGET} ${OBJS} ${LDADD}
.endif

.endif	# defined(OBJS) && !empty(OBJS)

.if !defined(MAN)
MAN=	${PROG}.1
.endif	# !defined(MAN)
.endif	# defined(PROG)

realall: ${PROG} ${SCRIPTS}

CLEANFILES+= a.out [Ee]rrs mklog core *.core \
	    ${PROG} ${OBJS} ${LOBJS}

.if defined(SRCS) && !target(afterdepend)
afterdepend: .depend
	@(TMP=/tmp/_depend$$$$; \
	    sed -e 's/^\([^\.]*\).o[ ]*:/\1.o \1.ln:/' \
	      < .depend > $$TMP; \
	    mv $$TMP .depend)
.endif

.if defined(PROG) && !target(proginstall)
PROGNAME?=${PROG}

proginstall:: ${DESTDIR}${BINDIR}/${PROGNAME}
.PRECIOUS: ${DESTDIR}${BINDIR}/${PROGNAME}
.PHONY: ${DESTDIR}${BINDIR}/${PROGNAME}

__proginstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} ${STRIPFLAG} \
	    -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} ${.ALLSRC} ${.TARGET}

${DESTDIR}${BINDIR}/${PROGNAME}: ${PROG} __proginstall
.endif

.if !target(proginstall)
proginstall::
.endif

.if defined(SCRIPTS) && !target(scriptsinstall)
SCRIPTSDIR?=${BINDIR}
SCRIPTSOWN?=${BINOWN}
SCRIPTSGRP?=${BINGRP}
SCRIPTSMODE?=${BINMODE}

scriptsinstall:: ${SCRIPTS:@S@${DESTDIR}${SCRIPTSDIR_${S}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S}:U${SCRIPTSNAME:U${S:T:R}}}@}
.PRECIOUS: ${SCRIPTS:@S@${DESTDIR}${SCRIPTSDIR_${S}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S}:U${SCRIPTSNAME:U${S:T:R}}}@}
.PHONY: ${SCRIPTS:@S@${DESTDIR}${SCRIPTSDIR_${S}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S}:U${SCRIPTSNAME:U${S:T:R}}}@}

__scriptinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} \
	    -o ${SCRIPTSOWN_${.ALLSRC:T}:U${SCRIPTSOWN}} \
	    -g ${SCRIPTSGRP_${.ALLSRC:T}:U${SCRIPTSGRP}} \
	    -m ${SCRIPTSMODE_${.ALLSRC:T}:U${SCRIPTSMODE}} \
	    ${.ALLSRC} ${.TARGET}

.for S in ${SCRIPTS:O:u}
${DESTDIR}${SCRIPTSDIR_${S}:U${SCRIPTSDIR}}/${SCRIPTSNAME_${S}:U${SCRIPTSNAME:U${S:T:R}}}: ${S} __scriptinstall
.endfor
.endif

.if !target(scriptsinstall)
scriptsinstall::
.endif

lint: ${LOBJS}
.if defined(LOBJS) && !empty(LOBJS)
	${LINT} ${LINTFLAGS} ${LDFLAGS:M-L*} ${LOBJS} ${LDADD}
.endif

.include <mkc_bsd.man.mk>
#.include <mkc_bsd.nls.mk>
.include <mkc_bsd.files.mk>
.include <mkc_bsd.inc.mk>
.include <mkc_bsd.links.mk>
#.include <mkc_bsd.dep.mk>
.include <mkc_bsd.sys.mk>

# Make sure all of the standard targets are defined, even if they do nothing.
regress:

.endif # _MKC_BSD_PROG_MK
