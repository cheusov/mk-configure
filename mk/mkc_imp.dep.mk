# Copyright (c) 2010-2013,2020 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.

######################################################################
.if !defined(_MKC_IMP_DEP_MK) && !empty(_SRCS_ALL)
_MKC_IMP_DEP_MK := 1

DISTCLEANFILES  +=	.depend *.d ${CLEANDEPEND}

##### Basic targets
do_depend1 do_depend2: .PHONY # ensure existence
realdo_depend: do_depend1 .WAIT do_depend2

##### Default values
MKDEP          ?=	mkdep
MKDEP_SUFFIXES ?=	.o .os .op
MKDEP_CC       ?=	${CC}

##### Build rules
# some of the rules involve .h sources, so remove them from mkdep line

.if defined(_SRCS_ALL)
__DPSRCS.all  =	${_SRCS_ALL:T:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/} \
		${DPSRCS:T:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/}
__DPSRCS.d    =	${__DPSRCS.all:O:u:M*.d}
__DPSRCS.notd =	${__DPSRCS.all:O:u:N*.d}

do_depend1: ${DPSRCS}
do_depend2: .depend

MESSAGE.dep ?=	@${_MESSAGE} "DEP: ${.TARGET}"

.NOPATH: .depend ${__DPSRCS.d}

.if !empty(__DPSRCS.d)
${__DPSRCS.d}: ${__DPSRCS.notd} ${DPSRCS}
.endif # __DPSRCS.d

.if ${MKDEP_TYPE:U} == "nbmkdep"
ddash=--
.else
ddash=
.endif

.if ${MKDEP_TYPE:U} == "makedepend"
MKDEP.c   = ${MAKEDEPEND} -f- ${ddash} ${MKDEPFLAGS} \
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS} > ${.TARGET}
MKDEP.cc  = ${MKDEP} -f- ${ddash} ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS} > ${.TARGET}
MKDEP.s   = ${MKDEP} -f- ${ddash} ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS} > ${.TARGET}
.else
MKDEP.c   = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS}
MKDEP.cc  = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS}
MKDEP.s   = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${_CPPFLAGS}
.endif

.depend: ${__DPSRCS.d}
	${MESSAGE.dep}
	@${RM} -f ${.TARGET}
.if ${MKDEP_TYPE:U} == "nbmkdep"
	@${MKDEP} -d -f ${.TARGET} -s ${MKDEP_SUFFIXES:Q} ${__DPSRCS.d}
.else
	@sed 's/^\([^ ]*\)[.]o\(.*\)$$/${MKDEP_SUFFIXES:C,^,\\\\1,}\2/' ${__DPSRCS.d} > ${.TARGET}
.endif

.SUFFIXES: .d .s .S .c .C .cc .cpp .cxx

.c.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC:Q} ${MKDEP.c} ${.IMPSRC}

.s.d .S.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC:Q} ${MKDEP.s} ${.IMPSRC}

.C.d .cc.d .cpp.d .cxx.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC:Q} ${MKDEP.cc} ${.IMPSRC}

.endif # defined(SRCS)

######################################################################
.endif # _MKC_IMP_DEP_MK
