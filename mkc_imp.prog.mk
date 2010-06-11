# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_PROG_MK)
_MKC_IMP_PROG_MK=1

.PHONY:		proginstall
realinstall:	proginstall

CFLAGS+=	${COPTS}

.if defined(PROG)

DPSRCS+=	${SRCS:M*.l:.l=.c} ${SRCS:M*.y:.y=.c}
CLEANFILES+=	${DPSRCS}
.if defined(YHEADER)
CLEANFILES+=	${SRCS:M*.y:.y=.h}
.endif

.if !empty(SRCS:N*.h:N*.sh:N*.fth)
OBJS+=		${SRCS:N*.h:N*.sh:N*.fth:T:R:S/$/.o/g}
.endif

.if defined(OBJS) && !empty(OBJS)
.NOPATH: ${OBJS}

${PROG}: ${LIBCRT0} ${DPSRCS} ${OBJS} ${LIBC} ${LIBCRTBEGIN} ${LIBCRTEND} ${DPADD}
.if !commands(${PROG})
	${MESSAGE.ld}
	${_V}${LDREAL} ${LDFLAGS} ${LDSTATIC} -o ${.TARGET} ${OBJS} ${LDADD}
.endif

.endif	# defined(OBJS) && !empty(OBJS)

.if !defined(MAN) && exists(${PROG}.1)
MAN=		${PROG}.1
.endif

PROGNAME?=${PROG}

.if ${MKINSTALL:tl} == "yes"
destination_prog=	${DESTDIR}${BINDIR}/${PROGNAME}
UNINSTALLFILES+=	${destination_prog}
INSTALLDIRS+=		${destination_prog:H}
.endif

proginstall:: ${destination_prog}
.PRECIOUS:    ${destination_prog}
.PHONY:       ${destination_prog}

__proginstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} ${STRIPFLAG} \
	    -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} ${.ALLSRC} ${.TARGET}

${DESTDIR}${BINDIR}/${PROGNAME}: ${PROG} __proginstall

.else # defined(PROG)
proginstall:
.endif # defined(PROG)

realall: ${PROG}

CLEANFILES+= a.out [Ee]rrs mklog core *.core \
	    ${PROG} ${OBJS}

.endif # _MKC_IMP_PROG_MK
