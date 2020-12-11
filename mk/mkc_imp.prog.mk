# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_MKC_IMP_PROG_MK)
_MKC_IMP_PROG_MK := 1

proginstall:	.PHONY # ensure existence

__proginstall: .USE
	${INSTALL}  ${INSTALL_FLAGS} ${STRIPFLAG} \
	    -o ${BINOWN:Q} -g ${BINGRP:Q} -m ${BINMODE} ${.ALLSRC} ${.TARGET}

.for p in ${PROGS}
do_install1:	proginstall

_SRCS_ALL += ${SRCS.${p}}

DPSRCS.${p} =	${SRCS.${p}:M*.l:.l=.c} ${SRCS.${p}:M*.y:.y=.c}
CLEANFILES +=	${DPSRCS.${p}}
.if defined(YHEADER)
CLEANFILES +=	${SRCS.${p}:M*.y:.y=.h}
.endif # defined(YHEADER)

OBJS.${p} =	${SRCS.${p}:N*.h:N*.sh:N*.fth:T:R:S/$/.o/g}

.if !empty(SRCS.${p}:N*.h:N*.sh:M*/*:H)
SRC_PATHADD +=	${SRCS:N*.h:N*.sh:M*/*:H}
.endif

.if defined(OBJS.${p}) && !empty(OBJS.${p})
.NOPATH: ${OBJS.${p}}

${p}: ${LIBCRT0} ${DPSRCS.${p}} ${OBJS.${p}} ${LIBC} ${LIBCRTBEGIN} ${LIBCRTEND} ${DPADD}
.if !commands(${p})
	${MESSAGE.ld}
	${_V}${LDREAL} -o ${.TARGET} ${OBJS.${p}} \
	    ${LDFLAGS0} ${LDADD0} \
	    ${LDFLAGS} ${LDFLAGS.prog} ${LDADD}
.endif # !commands(...)

.endif	# defined(OBJS.${p}) && !empty(OBJS.${p})

.if !defined(MAN) && exists(${p}.1)
.warning "Implicit manual pages are deprecated since 2020-12-09, please set variable MAN"
MAN +=		${p}.1
.endif # !defined(MAN)

PROGNAME.${p} ?=	${PROGNAME:U${p}}

.if ${MKINSTALL:tl} == "yes"
dest_prog.${p}   =	${DESTDIR}${BINDIR}/${PROGNAME.${p}}
UNINSTALLFILES  +=	${dest_prog.${p}}
INSTALLDIRS     +=	${dest_prog.${p}:H}

proginstall: ${dest_prog.${p}}
.PRECIOUS:    ${dest_prog.${p}}
.PHONY:       ${dest_prog.${p}}
.endif # ${MKINSTALL:tl} == "yes"

${DESTDIR}${BINDIR}/${PROGNAME.${p}}: ${p} __proginstall

.endfor # ${PROGS}

.if !empty(PROGS)
CLEANFILES +=	*.o
.endif

realdo_all: ${PROGS}

CLEANFILES += ${PROGS}

.endif # _MKC_IMP_PROG_MK
