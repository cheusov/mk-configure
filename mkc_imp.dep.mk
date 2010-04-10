# Copyright (c) 2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.

DISTCLEANFILES+=	.depend ${__DPSRCS.d} ${CLEANDEPEND}

##### Basic targets
realdepend:	.depend
.depend:

##### Default values
MKDEP?=			mkdep
MKDEP_SUFFIXES?=	.o

##### Build rules
# some of the rules involve .h sources, so remove them from mkdep line

.if defined(SRCS)							# {
_TRADITIONAL_CPP?=-traditional-cpp
__acpp_flags=	${_TRADITIONAL_CPP}

__DPSRCS.all=	${SRCS:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/} \
		${DPSRCS:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/}
__DPSRCS.d=	${__DPSRCS.all:O:u:M*.d}
__DPSRCS.notd=	${__DPSRCS.all:O:u:N*.d}

.NOPATH: .depend ${__DPSRCS.d}

.if !empty(__DPSRCS.d)							# {
${__DPSRCS.d}: ${__DPSRCS.notd} ${DPSRCS}
.endif									# }

.depend: ${__DPSRCS.d}
	${_MKTARGET_CREATE}
	rm -f .depend
	${MKDEP} -d -f ${.TARGET} -s ${MKDEP_SUFFIXES:Q} ${__DPSRCS.d}

.SUFFIXES: .d .s .S .c .C .cc .cpp .cxx .m

.c.d:
	${_MKTARGET_CREATE}
	${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.m.d:
	${_MKTARGET_CREATE}
	${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${OBJCFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.s.d .S.d:
	${_MKTARGET_CREATE}
	${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${__acpp_flags} ${.IMPSRC}

.C.d .cc.d .cpp.d .cxx.d:
	${_MKTARGET_CREATE}
	${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${DESTDIR:D-nostdinc++ ${CPPFLAG_ISYSTEMXX} \
			${DESTDIR}/usr/include/g++} \
	    ${CPPFLAGS} ${.IMPSRC}

.endif # defined(SRCS)							# }
