# Copyright (c) 2010-1013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.

######################################################################
.ifndef _MKC_IMP_DEP_MK
_MKC_IMP_DEP_MK := 1

DISTCLEANFILES  +=	.depend ${__DPSRCS.d} ${CLEANDEPEND}

##### Basic targets
.PHONY: _beforedepend depend
_beforedepend .depend: # ensure existence

.ORDER: _beforedepend .depend
depend: _beforedepend .depend

##### Default values
MKDEP          ?=	mkdep
MKDEP_SUFFIXES ?=	.o .os .op
MKDEP_CC       ?=	${CC}

##### Build rules
# some of the rules involve .h sources, so remove them from mkdep line

.if defined(_SRCS_ALL)
__DPSRCS.all  =	${_SRCS_ALL:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/} \
		${DPSRCS:C/\.(c|m|s|S|C|cc|cpp|cxx)$/.d/}
__DPSRCS.d    =	${__DPSRCS.all:O:u:M*.d}
__DPSRCS.notd =	${__DPSRCS.all:O:u:N*.d}

_beforedepend: ${DPSRCS}

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
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS} > ${.TARGET}
MKDEP.m   = ${MKDEP} -f- ${ddash} ${MKDEPFLAGS} \
	    ${OBJCFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS} > ${.TARGET}
MKDEP.cc  = ${MKDEP} -f- ${ddash} ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS} > ${.TARGET}
MKDEP.s   = ${MKDEP} -f- ${ddash} ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS} > ${.TARGET}
.else
MKDEP.c   = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${CFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS}
MKDEP.m   = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${OBJCFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS}
MKDEP.cc  = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${CXXFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS}
MKDEP.s   = ${MKDEP} -f ${.TARGET} ${ddash} ${MKDEPFLAGS} \
	    ${AFLAGS:C/-([IDU])[  ]*/-\1/Wg:M-[IDU]*} ${CPPFLAGS}
.endif

.depend: ${__DPSRCS.d}
	${MESSAGE.dep}
	@${RM} -f ${.TARGET}
.if ${MKDEP_TYPE:U} == "nbmkdep"
	@${MKDEP} -d -f ${.TARGET} -s ${MKDEP_SUFFIXES:Q} ${__DPSRCS.d}
.else
	@sed 's/^\([^ ]*\)[.]o\(.*\)$$/${MKDEP_SUFFIXES:C,^,\\\\1,}\2/' ${__DPSRCS.d} > ${.TARGET}
.endif

.SUFFIXES: .d .s .S .c .C .cc .cpp .cxx .m

.c.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC} ${MKDEP.c} ${.IMPSRC}

.m.d:
	${MESSAGE.dep}
	@${MKDEP.m} ${.IMPSRC}

.s.d .S.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC} ${MKDEP.s} ${.IMPSRC}

.C.d .cc.d .cpp.d .cxx.d:
	${MESSAGE.dep}
	@env CC=${MKDEP_CC} ${MKDEP.cc} ${.IMPSRC}

.endif # defined(SRCS)

######################################################################
.endif # _MKC_IMP_DEP_MK
