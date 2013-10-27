# Copyright (c) 2010-1013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.

######################################################################
.ifndef _MKC_IMP_DEP_MK
_MKC_IMP_DEP_MK := 1

CLEANFILES  +=	.depend ${__DPSRCS.d} ${CLEANDEPEND}

##### Basic targets
depend: .depend
.depend:

##### Default values
MKDEP          ?=	mkdep
MKDEP_SUFFIXES ?=	.o

##### Build rules
# some of the rules involve .h sources, so remove them from mkdep line

.if defined(SRCS)
__DPSRCS.all  =	${SRCS:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/} \
		${DPSRCS:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/}
__DPSRCS.d    =	${__DPSRCS.all:O:u:M*.d}
__DPSRCS.notd =	${__DPSRCS.all:O:u:N*.d}

MESSAGE.dep ?=	@${_MESSAGE} "DEP: ${.TARGET}"

.NOPATH: .depend ${__DPSRCS.d}

.if !empty(__DPSRCS.d)
${__DPSRCS.d}: ${__DPSRCS.notd} ${DPSRCS}
.endif # __DPSRCS.d

.depend: ${__DPSRCS.d}
	${MESSAGE.dep};
	@rm -f .depend
	@${MKDEP} -d -f ${.TARGET} -s ${MKDEP_SUFFIXES:Q} ${__DPSRCS.d}

.SUFFIXES: .d .s .S .c .C .cc .cpp .cxx .m

.c.d:
	${MESSAGE.dep}
	@${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.m.d:
	${MESSAGE.dep}
	@${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${OBJCFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.s.d .S.d:
	${MESSAGE.dep}
	@${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.C.d .cc.d .cpp.d .cxx.d:
	${MESSAGE.dep}
	@${MKDEP} -f ${.TARGET} -- ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} \
	    ${CPPFLAGS} ${.IMPSRC}

.endif # defined(SRCS)

######################################################################
.endif # _MKC_IMP_DEP_MK
