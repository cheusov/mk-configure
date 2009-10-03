#	$NetBSD: bsd.lib.mk,v 1.3 2009/04/07 23:42:17 tez Exp $
#	@(#)bsd.lib.mk	8.3 (Berkeley) 4/22/94

.if !defined(_MKC_BSD_LIB_MK)
_MKC_BSD_LIB_MK=1

.include <mkc_bsd.init.mk>

.PHONY:		libinstall
.if !empty(MKINSTALL:M[Yy][Ee][Ss])
realinstall:	libinstall
.endif # MKINSTALL

# add additional suffixes not exported.
# .po is used for profiling object files.
# .so is used for PIC object files.
.SUFFIXES: .out .a .so .po .o .s .S .c .cc .C .m .F .f .r .y .l .cl .p .h
.SUFFIXES: .sh .m4 .m


# Set PICFLAGS to cc flags for producing position-independent code,
# if not already set.  Includes -DPIC, if required.

# Data-driven table using make variables to control how shared libraries
# are built for different platforms and object formats.
# OBJECT_FMT:		currently either "ELF" or "a.out", from <bsd.own.mk>
# SHLIB_SHFLAGS:	Flags to tell ${LD} to emit shared library.
#			with ELF, also set shared-lib version for ld.so.
#
# FFLAGS.PIC:		flags for ${FC} to compile .[fF] files to .so objects.
# CPPICFLAGS:		flags for ${CPP} to preprocess .[sS] files for ${AS}
# CFLAGS.PIC:		flags for ${CC} to compile .[cC] files to .so objects.
# CAFLAGS.PIC		flags for {$CC} to compiling .[Ss] files
#		 	(usually just ${CPPFLAGS.PIC} ${CFLAGS.PIC})
# AFLAGS.PIC:		flags for ${AS} to assemble .[sS] to .so objects.

.if ${MACHINE_ARCH} == "alpha"
		# Alpha-specific shared library flags
FFLAGS.PIC ?= -fPIC
CFLAGS.PIC ?= -fPIC -DPIC
CPPFLAGS.PIC?= -DPIC 
CAFLAGS.PIC?= ${CPPFLAGS.PIC} ${CFLAGS.PIC}
AFLAGS.PIC ?=
.elif ${MACHINE_ARCH} == "mipsel" || ${MACHINE_ARCH} == "mipseb"
		# mips-specific shared library flags

# On mips, all libs are compiled with ABIcalls, not just sharedlibs.
MKPICLIB= no

# so turn shlib PIC flags on for ${AS}.
AINC+=-DABICALLS
AFLAGS+= -fPIC
AS+=	-KPIC

.elif ${MACHINE_ARCH} == "vax" && ${OBJECT_FMT} == "ELF"
# On the VAX, all object are PIC by default, not just sharedlibs.
MKPICLIB= no

.elif (${MACHINE_ARCH} == "sparc" || ${MACHINE_ARCH} == "sparc64") && \
       ${OBJECT_FMT} == "ELF"

FFLAGS.PIC ?= -fPIC
CFLAGS.PIC ?= -fPIC -DPIC
CPPFLAGS.PIC?= -DPIC 
CAFLAGS.PIC?= ${CPPFLAGS.PIC} ${CFLAGS.PIC}
AFLAGS.PIC ?= -KPIC

.else

# Platform-independent flags for NetBSD a.out shared libraries (and PowerPC)
SHLIB_SHFLAGS=
FFLAGS.PIC ?= -fPIC
CFLAGS.PIC?= -fPIC -DPIC
CPPFLAGS.PIC?= -DPIC 
CAFLAGS.PIC?= ${CPPFLAGS.PIC} ${CFLAGS.PIC}
AFLAGS.PIC?= -k

.endif

MKPICLIB?= yes

# Platform-independent linker flags for ELF shared libraries
.if ${OBJECT_FMT} == "ELF"
SHLIB_SHFLAGS?=		-soname lib${LIB}${SHLIB_EXT1}
.endif

CFLAGS+=	${COPTS}
FFLAGS+=	${FOPTS}

.c.o:
	${COMPILE.c} ${.IMPSRC}

.c.po:
	${COMPILE.c} -pg ${.IMPSRC} -o ${.TARGET}

.c.so:
	${COMPILE.c} ${CFLAGS.PIC} ${.IMPSRC} -o ${.TARGET}

.cc.o .C.o:
	${COMPILE.cc} ${.IMPSRC}

.cc.po .C.po:
	${COMPILE.cc} -pg ${.IMPSRC} -o ${.TARGET}

.cc.so .C.so:
	${COMPILE.cc} ${CFLAGS.PIC} ${.IMPSRC} -o ${.TARGET}

.f.o:
	${COMPILE.f} ${.IMPSRC}

.f.po:
	${COMPILE.f} -pg ${.IMPSRC} -o ${.TARGET}

.f.so:
	${COMPILE.f} ${FFLAGS.PIC} ${.IMPSRC} -o ${.TARGET}

.m.o:
	${COMPILE.m} ${.IMPSRC}

.m.po:
	${COMPILE.m} -pg ${.IMPSRC} -o ${.TARGET}

.m.so:
	${COMPILE.m} ${CFLAGS.PIC} ${.IMPSRC} -o ${.TARGET}

.S.o .s.o:
	${COMPILE.S} ${AINC} ${.IMPSRC} -o ${.TARGET}

.S.po .s.po:
	${COMPILE.S} ${PROFFLAGS} ${AINC} ${.IMPSRC} -o ${.TARGET}

.S.so .s.so:
	${COMPILE.S} ${CAFLAGS.PIC} ${AINC} ${.IMPSRC} -o ${.TARGET}

_LIBS=lib${LIB}.a

OBJS+=${SRCS:N*.h:N*.sh:R:S/$/.o/g}

.if ${MKPROFILE} != "no"
_LIBS+=lib${LIB}_p.a
POBJS+=${OBJS:.o=.po}
.endif

.if ${MKPIC} != "no"
.if ${MKPICLIB} == "no"
SOLIB=lib${LIB}.a
.else
SOLIB=lib${LIB}_pic.a
_LIBS+=${SOLIB}
SOBJS+=${OBJS:.o=.so}
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
	$(LD) ${LDFLAGS_SHARED} ${SHLIB_SHFLAGS} -o ${.TARGET} \
	    ${SOBJS} ${LDADD}
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
	    sed -e 's/^\([^\.]*\).o[ ]*:/\1.o \1.po \1.so:/' \
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

.include <mkc_bsd.man.mk>
#.include <mkc_bsd.nls.mk>
.include <mkc_bsd.files.mk>
.include <mkc_bsd.inc.mk>
.include <mkc_bsd.links.mk>
#.include <mkc_bsd.dep.mk>
.include <mkc_bsd.sys.mk>

.endif #_MKC_BSD_LIB_MK
