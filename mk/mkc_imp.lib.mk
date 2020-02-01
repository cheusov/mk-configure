# Copyright (c) 2009-2014 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See LICENSE file in the distribution.
############################################################

.if !defined(_MKC_IMP_LIB_MK)
_MKC_IMP_LIB_MK := 1

.PHONY:		libinstall
.if ${MKINSTALL:tl} == "yes"
do_install1:	libinstall
INSTALLDIRS    +=	${DESTDIR}${LIBDIR}
UNINSTALLFILES +=	${UNINSTALLFILES.lib}
.endif # MKINSTALL

# Set PICFLAGS to cc flags for producing position-independent code,
# if not already set.  Includes -DPIC, if required.

# Data-driven table using make variables to control how shared libraries
# are built for different platforms and object formats.
# OBJECT_FMT:		currently either "ELF" or "a.out", from <bsd.own.mk>
# LDFLAGS.soname:	Flags to tell ${LD} to emit shared library.
#			with ELF, also set shared-lib version for ld.so.
#
# CPPICFLAGS:		flags for ${CPP} to preprocess .[sS] files for ${AS}
# CFLAGS.pic:		flags for ${CC} to compile .[cC] files to .os objects.
# CAFLAGS.pic		flags for {$CC} to compiling .[Ss] files
#		 	(usually just ${CPPFLAGS.pic} ${CFLAGS.pic})
# AFLAGS.pic:		flags for ${AS} to assemble .[sS] to .os objects.

OBJS  +=	${SRCS:N*.h:N*.sh:T:R:S/$/.o/g}
SOBJS  =	${OBJS:.o=.os}
POBJS  =	${OBJS:.o=.op}

.if !empty(SRCS:N*.h:N*.sh:M*/*:H)
SRC_PATHADD +=	${SRCS:N*.h:N*.sh:M*/*:H}
.endif

.if ${MKSTATICLIB:tl} != "no"
_LIBS +=	lib${LIB}.a
.endif

.if ${MKPROFILELIB:tl} != "no"
_LIBS +=	lib${LIB}_p.a
.endif

.if ${MKPICLIB:tl} != "no"
_LIBS +=	lib${LIB}_pic.a
.endif # MKPICLIB

.if ${MKSHLIB:tl} != "no"
.if ${MKDLL:tl} == "no"
SHLIBFN  =	lib${LIB}${SHLIB_EXTFULL}
.else
SHLIBFN  =	${LIB}${DLL_EXT}
.endif
_LIBS   +=	${SHLIBFN}
.endif

.NOPATH: ${_LIBS}

realdo_all: ${SRCS} ${_LIBS}

_SRCS_ALL = ${SRCS}

__archivebuild: .USE
	@${RM} -f ${.TARGET}
	${MESSAGE.ar}
	${_V} ${AR} cq ${.TARGET} ${.ALLSRC}; \
	${RANLIB} ${.TARGET}

__archiveinstall: .USE
	${INSTALL}  ${INSTALL_FLAGS} -o ${LIBOWN:Q} \
	    -g ${LIBGRP:Q} -m ${LIBMODE} ${.ALLSRC} ${.TARGET}

DPSRCS     +=	${SRCS:M*.l:.l=.c} ${SRCS:M*.y:.y=.c}
CLEANFILES +=	${DPSRCS}
.if defined(YHEADER)
CLEANFILES +=	${SRCS:M*.y:.y=.h}
.endif

lib${LIB}.a:: ${OBJS} __archivebuild
	@${_MESSAGE_V} "building standard ${LIB} library"

lib${LIB}_p.a:: ${POBJS} __archivebuild
	@${_MESSAGE_V} "building profiled ${LIB} library"

lib${LIB}_pic.a:: ${SOBJS} __archivebuild
	@${_MESSAGE_V} "building shared object ${LIB} library"

${SHLIBFN}: ${SOBJS} ${DPADD}
.if !commands(${SHLIBFN})
	@${_MESSAGE_V} building shared ${LIB} library \(version ${SHLIB_FULLVERSION}\)
	@${RM} -f ${.TARGET}
	@${_MESSAGE} "LD: ${.TARGET}"
	${_V} $(LDREAL) ${LDFLAGS.shlib} -o ${.TARGET} \
	    ${SOBJS} ${LDFLAGS0} ${LDADD0} ${LDFLAGS} ${LDADD}
.if ${OBJECT_FMT} == "ELF" && ${MKDLL:tl} == "no"
	@${LN_S} -f ${SHLIBFN} lib${LIB}${SHLIB_EXT}
	@${LN_S} -f ${SHLIBFN} lib${LIB}${SHLIB_EXT1}
.endif # ELF
.endif # !commands(...)

CLEANFILES += \
	${OBJS} ${POBJS} ${SOBJS}

.if !target(libinstall)
# Make sure it gets defined
libinstall::

CLEANFILES   +=	lib${LIB}.a lib${LIB}_pic.a lib${LIB}_p.a

   # MKSTATICLIB
.if ${MKSTATICLIB:tl} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}.a
UNINSTALLFILES.lib +=	${DESTDIR}${LIBDIR}/lib${LIB}.a

${DESTDIR}${LIBDIR}/lib${LIB}.a: lib${LIB}.a __archiveinstall
.endif

   # MKPROFILELIB
.if ${MKPROFILELIB:tl} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
UNINSTALLFILES.lib +=	${DESTDIR}${LIBDIR}/lib${LIB}_p.a

${DESTDIR}${LIBDIR}/lib${LIB}_p.a: lib${LIB}_p.a __archiveinstall
.endif

   # MKPICLIB
.if ${MKPICLIB:tl} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
UNINSTALLFILES.lib +=	${DESTDIR}${LIBDIR}/lib${LIB}_pic.a

${DESTDIR}${LIBDIR}/lib${LIB}_pic.a: lib${LIB}_pic.a __archiveinstall
.endif

   # MKSHLIB
.if ${MKSHLIB:tl} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/${SHLIBFN}
.PRECIOUS: ${DESTDIR}${LIBDIR}/${SHLIBFN}
.PHONY: ${DESTDIR}${LIBDIR}/${SHLIBFN}
UNINSTALLFILES.lib += ${DESTDIR}${LIBDIR}/${SHLIBFN}
.if ${MKDLL:tl} == "no"
UNINSTALLFILES.lib +=	${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT} \
			${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT1}
CLEANFILES += \
	lib${LIB}${SHLIB_EXT} lib${LIB}${SHLIB_EXT1} \
	lib${LIB}${SHLIB_EXT2} ${SHLIB_EXT3:Dlib${LIB}${SHLIB_EXT3}}
.else
CLEANFILES += ${SHLIBFN}
.endif

${DESTDIR}${LIBDIR}/${SHLIBFN}: ${SHLIBFN}
	${INSTALL}  ${INSTALL_FLAGS} -o ${LIBOWN:Q} \
	    -g ${LIBGRP:Q} -m ${SHLIBMODE} ${.ALLSRC} ${.TARGET}
.if ${OBJECT_FMT} == "a.out" && !defined(DESTDIR) && ${MKDLL:tl} == "no"
	/sbin/ldconfig -m ${LIBDIR}
.endif
.if ${OBJECT_FMT} == "ELF" && ${MKDLL:tl} == "no"
	${LN_S} -f ${SHLIBFN} \
	    ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT1}
	${LN_S} -f ${SHLIBFN} \
	    ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT}
.endif
.endif
.endif

.endif #_MKC_IMP_LIB_MK
