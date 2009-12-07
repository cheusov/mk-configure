# Copyright (c) 2009 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_MKC_IMP_LIB_MK)
_MKC_IMP_LIB_MK=1

.include <mkc_imp.init.mk>

.PHONY:		libinstall
.if !empty(MKINSTALL:M[Yy][Ee][Ss])
realinstall:	libinstall
.endif # MKINSTALL

# add additional suffixes not exported.
# .op is used for profiling object files.
# .os is used for PIC object files.
.SUFFIXES: .out .a .so .os .po .op .o .s .S .c .cc .cpp .C .m .F .f .r .y .l .cl .p .h
.SUFFIXES: .sh .m4 .m


# Set PICFLAGS to cc flags for producing position-independent code,
# if not already set.  Includes -DPIC, if required.

# Data-driven table using make variables to control how shared libraries
# are built for different platforms and object formats.
# OBJECT_FMT:		currently either "ELF" or "a.out", from <bsd.own.mk>
# LDFLAGS.soname:	Flags to tell ${LD} to emit shared library.
#			with ELF, also set shared-lib version for ld.so.
#
# FFLAGS.pic:		flags for ${FC} to compile .[fF] files to .os objects.
# CPPICFLAGS:		flags for ${CPP} to preprocess .[sS] files for ${AS}
# CFLAGS.pic:		flags for ${CC} to compile .[cC] files to .os objects.
# CAFLAGS.pic		flags for {$CC} to compiling .[Ss] files
#		 	(usually just ${CPPFLAGS.pic} ${CFLAGS.pic})
# AFLAGS.pic:		flags for ${AS} to assemble .[sS] to .os objects.

MKPICLIB?= yes

CFLAGS+=	${COPTS}
FFLAGS+=	${FOPTS}

.c.o:
	${COMPILE.c} ${.IMPSRC}

.c.op:
	${COMPILE.c} -pg ${.IMPSRC} -o ${.TARGET}

.c.os:
	${COMPILE.c} ${CFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

.cc.o .C.o .cpp.o:
	${COMPILE.cc} ${.IMPSRC}

.cc.op .C.op .cpp.op:
	${COMPILE.cc} -pg ${.IMPSRC} -o ${.TARGET}

.cc.os .C.os .cpp.os:
	${COMPILE.cc} ${CXXFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

.f.o:
	${COMPILE.f} ${.IMPSRC}

.f.op:
	${COMPILE.f} -pg ${.IMPSRC} -o ${.TARGET}

.f.os:
	${COMPILE.f} ${FFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

.m.o:
	${COMPILE.m} ${.IMPSRC}

.m.op:
	${COMPILE.m} -pg ${.IMPSRC} -o ${.TARGET}

.m.os:
	${COMPILE.m} ${CFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

.S.o .s.o:
	${COMPILE.S} ${AINC} ${.IMPSRC} -o ${.TARGET}

.S.op .s.op:
	${COMPILE.S} ${PROFFLAGS} ${AINC} ${.IMPSRC} -o ${.TARGET}

.S.os .s.os:
	${COMPILE.S} ${CAFLAGS.pic} ${AINC} ${.IMPSRC} -o ${.TARGET}

_LIBS=lib${LIB}.a

OBJS+=${SRCS:N*.h:N*.sh:T:R:S/$/.o/g}

.if ${MKPROFILE} != "no"
_LIBS+=lib${LIB}_p.a
POBJS+=${OBJS:.o=.op}
.endif

.if ${MKPIC} != "no"
.if ${MKPICLIB} == "no"
SOLIB=lib${LIB}.a
.else
SOLIB=lib${LIB}_pic.a
_LIBS+=${SOLIB}
SOBJS+=${OBJS:.o=.os}
.endif
.if defined(SHLIB_FULLVERSION)
_LIBS+=lib${LIB}${SHLIB_EXTFULL}
.endif
.endif

ALLOBJS=${OBJS} ${POBJS} ${SOBJS}
.NOPATH: ${ALLOBJS} ${_LIBS}

realall: ${SRCS} ${ALLOBJS:O} ${_LIBS}

__archivebuild: .USE
	@rm -f ${.TARGET}
	${AR} cq ${.TARGET} ${.ALLSRC}
	${RANLIB} ${.TARGET}

__archiveinstall: .USE
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} -o ${LIBOWN} \
	    -g ${LIBGRP} -m 600 ${.ALLSRC} ${.TARGET}
	chmod ${LIBMODE} ${.TARGET}

DPSRCS+=	${SRCS:M*.l:.l=.c} ${SRCS:M*.y:.y=.c}
CLEANFILES+=	${DPSRCS}
.if defined(YHEADER)
CLEANFILES+=	${SRCS:M*.y:.y=.h}
.endif

lib${LIB}.a:: ${OBJS} __archivebuild
	@echo building standard ${LIB} library

lib${LIB}_p.a:: ${POBJS} __archivebuild
	@echo building profiled ${LIB} library

lib${LIB}_pic.a:: ${SOBJS} __archivebuild
	@echo building shared object ${LIB} library

lib${LIB}${SHLIB_EXTFULL}: ${SOLIB} ${DPADD}
.if !commands(lib${LIB}${SHLIB_EXTFULL})
	@echo building shared ${LIB} library \(version ${SHLIB_FULLVERSION}\)
	@rm -f lib${LIB}.${SHLIB_EXTFULL}
	$(LDREAL) ${LDFLAGS.shared} ${LDFLAGS.soname} -o ${.TARGET} \
	    ${SOBJS} ${LDFLAGS} ${LDADD}

.if ${OBJECT_FMT} == "ELF"
	ln -sf lib${LIB}${SHLIB_EXTFULL} lib${LIB}.tmp
	mv -f lib${LIB}.tmp lib${LIB}${SHLIB_EXT}
	ln -sf lib${LIB}${SHLIB_EXTFULL} lib${LIB}.tmp
	mv -f lib${LIB}.tmp lib${LIB}${SHLIB_EXT1}
.endif # ELF
.endif # !commands(...)

CLEANFILES+= a.out [Ee]rrs mklog core *.core \
	lib${LIB}.a ${OBJS} lib${LIB}_p.a ${POBJS} \
	lib${LIB}_pic.a ${SOBJS} \
	lib${LIB}${SHLIB_EXT} lib${LIB}${SHLIB_EXT1} \
	lib${LIB}${SHLIB_EXT2} lib${LIB}${SHLIB_EXT3}

.if defined(SRCS)
afterdepend: .depend
	@(TMP=/tmp/_depend$$$$; \
	    sed -e 's/^\([^\.]*\).o[ ]*:/\1.o \1.op \1.os:/' \
	      < .depend > $$TMP; \
	    mv $$TMP .depend)
.endif

.if !target(libinstall)
# Make sure it gets defined, in case MKPIC==no
libinstall::

libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}.a
UNINSTALLFILES+= ${DESTDIR}${LIBDIR}/lib${LIB}.a

${DESTDIR}${LIBDIR}/lib${LIB}.a: lib${LIB}.a __archiveinstall

.if ${MKPROFILE} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}_p.a
UNINSTALLFILES+= ${DESTDIR}${LIBDIR}/lib${LIB}_p.a

${DESTDIR}${LIBDIR}/lib${LIB}_p.a: lib${LIB}_p.a __archiveinstall
.endif

.if ${MKPIC} != "no" && ${MKPICINSTALL} != "no"
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
UNINSTALLFILES+= ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a

.if ${MKPICLIB} == "no"
${DESTDIR}${LIBDIR}/lib${LIB}_pic.a:
	rm -f ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
	ln -s lib${LIB}.a ${DESTDIR}${LIBDIR}/lib${LIB}_pic.a
.else
${DESTDIR}${LIBDIR}/lib${LIB}_pic.a: lib${LIB}_pic.a __archiveinstall
.endif
.endif

.if ${MKPIC} != "no" && defined(SHLIB_FULLVERSION)
libinstall:: ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
.PRECIOUS: ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
.PHONY: ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}
UNINSTALLFILES+= ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXTFULL} \
		${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT} \
		${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT1}

${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXTFULL}: lib${LIB}${SHLIB_EXTFULL}
	${INSTALL} ${RENAME} ${PRESERVE} ${COPY} -o ${LIBOWN} \
	    -g ${LIBGRP} -m ${LIBMODE} ${.ALLSRC} ${.TARGET}
.if ${OBJECT_FMT} == "a.out" && !defined(DESTDIR)
	/sbin/ldconfig -m ${LIBDIR}
.endif
.if ${OBJECT_FMT} == "ELF"
	ln -sf lib${LIB}${SHLIB_EXTFULL}\
	    ${DESTDIR}${LIBDIR}/lib${LIB}.tmp
	mv -f ${DESTDIR}${LIBDIR}/lib${LIB}.tmp\
	    ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT1}
	ln -sf lib${LIB}${SHLIB_EXTFULL}\
	    ${DESTDIR}${LIBDIR}/lib${LIB}.tmp
	mv -f ${DESTDIR}${LIBDIR}/lib${LIB}.tmp\
	    ${DESTDIR}${LIBDIR}/lib${LIB}${SHLIB_EXT}
.endif
.endif
.endif

INSTALLDIRS+=	${DESTDIR}${LIBDIR}

.include <mkc_imp.man.mk>
#.include <mkc_imp.nls.mk>
.include <mkc_imp.files.mk>
.include <mkc_imp.inc.mk>
.include <mkc_imp.links.mk>
#.include <mkc_imp.dep.mk>
.include <mkc_imp.sys.mk>

.include <mkc_imp.final.mk>

.endif #_MKC_IMP_LIB_MK
