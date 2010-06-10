# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef OPSYS
OPSYS!=		uname -s
OPSYS:=		${OPSYS:C/^CYGWIN.*$/Cygwin/}
.endif
TARGET_OPSYS?=  ${OPSYS}

###########
.ifdef DPLIBDIRS
.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir:T}
DPLIBDIRS.${_dir:T}!= 	cd ${_dir} && ${MAKE} ${MAKEFLAGS} mkc_printobjdir SKIP_CONFIGURE_MK=1
.if ${TARGET_OPSYS} == "HP-UX"
LDFLAGS+=		${CFLAGS.cctold}+b ${CFLAGS.cctold}${LIBDIR}
.endif
LDFLAGS+=		-L${DPLIBDIRS.${_dir:T}}
.endif
.endfor

.undef DPLIBDIRS

.endif # DPLIBDIRS

######################################################################
.ifndef __initialized__
__initialized__=1

.MAIN:		all

###########
.if defined(MKC_BOOTSTRAP) || defined(SKIP_CONFIGURE_MK)
.sinclude <mkc_imp.vars.mk>
.else
.include <mkc_imp.vars.mk>
.endif

#.if defined(MKC_SHELL)
#.SHELL: name=${MKC_SHELL}
#.elif ${OPSYS} == "SunOS"
#.SHELL: name=/usr/xpg4/bin/sh
#.endif

###########

.if defined(PROG)
SRCS?=		${PROG}.c
.endif

.if defined(LIB)
SRCS?=		${LIB}.c
.endif

.if !empty(SRCS:U:M*.cxx) || !empty(SRCS:U:M*.cpp) || !empty(SRCS:U:M*.C) || !empty(SRCS:U:M*.cc)
src_type+=	cxx
LDCOMPILER=	yes
LDREAL?=	${CXX}
.endif

LDCOMPILER.Interix=	yes
LDCOMPILER.Darwin=	yes
#LDCOMPILER.HP-UX=	yes
LDCOMPILER?=		${LDCOMPILER.${TARGET_OPSYS}:Uno}

.if !empty(SRCS:U:M*.c) || !empty(SRCS:U:M*.l) || !empty(SRCS:U:M*.y) || defined(MKC_SOURCE_FUNCLIBS)
src_type+=	c
.endif

src_type?=	0

.if ${LDCOMPILER:tl} == "yes"
LDREAL?=	${CC}
.endif

.if defined(PROG)
LDREAL?=	${CC}
.else
LDREAL?=	${LD}
.endif

###########
MKC_CACHEDIR?=${.OBJDIR} # directory for cache and intermediate files

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_imp.own.mk>

###########
.if !empty(SRCS:U:M*.y)
MKC_REQUIRE_PROGS+=			${YACC:[1]}
MKC_PROG.id.${YACC:[1]:S/+/x/g}=	yacc
.endif

.if !empty(SRCS:U:M*.l)
MKC_REQUIRE_PROGS+=			${LEX:[1]}
MKC_CHECK_FUNCLIBS+=			main:l main:fl
MKC_PROG.id.${LEX:[1]:S/+/x/g}=		lex
.endif

.if !empty(SRCS:U:M*.c) || !empty(SRCS:U:M*.l) || !empty(SRCS:U:M*.y)
MKC_REQUIRE_PROGS+=			${CC:[1]}
MKC_PROG.id.${CC:[1]:S|+|x|g}=		cc
.endif

.if !empty(SRCS:U:M*.cc) || !empty(SRCS:U:M*.C) || !empty(SRCS:U:M*.cxx) || !empty(SRCS:U:M*.cpp)
MKC_REQUIRE_PROGS+=			${CXX:[1]}
MKC_PROG.id.${CXX:[1]:S/+/x/g}=		cxx
.endif

.if !empty(SRCS:U:M*.f)
MKC_REQUIRE_PROGS+=			${FC:[1]}
MKC_PROG.id.${FC:[1]:S/+/x/g}=		fc
.endif

.if !empty(SRCS:U:M*.p)
MKC_REQUIRE_PROGS+=			${PC:[1]}
MKC_PROG.id.${PC:[1]:S/+/x/g}=		pc
.endif

###########
.PHONY: clean
clean:
	-rm -f ${CLEANFILES} 2>/dev/null
	-rm -rf ${CLEANDIRS} 2>/dev/null

###########
.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

.PHONY : print-values2
print-values2 :
.for v in ${VARS}
	@printf "%s\n" ${${v}:Q}
.endfor

###########
.PHONY : all mkc_printobjdir
mkc_printobjdir:
	@echo ${.OBJDIR}

###########

distclean: cleandir
.if !defined(SUBDIR) && !defined(SUBPRJ) && !commands(cleandir)
cleandir: mkc_cleandir
.endif

mkc_cleandir:
	-rm -f ${DISTCLEANFILES} ${CLEANFILES} 2>/dev/null
	-rm -rf ${DISTCLEANDIRS} ${CLEANDIRS} 2>/dev/null

.PHONY: errorcheck realall all
.if !defined(SUBDIR) && !defined(SUBPRJ)
realall : errorcheck
.endif
errorcheck:
	@if test -n '${MKC_ERR_MSG}'; then \
	    for msg in '' ${MKC_ERR_MSG}; do \
		fn=`printf '%s\n' "$$msg" | sed -n 's/^%%%: //p'`; \
		if test -n "$$fn"; then \
		    awk '{print "ERROR: " $$0}' "$$fn"; \
		elif test -n "$$msg"; then printf '%s\n' "$$msg"; ex=1; \
		fi; \
	    done; \
	    exit $$ex; \
	fi

###########

# Make sure all of the standard targets are defined, even if they do nothing.
#.PHONY : test all distclean cleandir clean
#test all distclean cleandir clean:

###########

.if defined(MKC_REQD) && defined(MKC_VERSION)
_mkc_version_ok!=	mkc_check_version ${MKC_REQD} ${MKC_VERSION}
.if !${_mkc_version_ok}
MKC_ERR_MSG+=	"ERROR: We need mk-configure v.${MKC_REQD} while ${MKC_VERSION} is detected"
.endif
.endif

###########

LDLIBS=		${LDFLAGS} ${LDADD}

###########
# skip uninstalling files and creating destination dirs
# for mkc.subdir.mk and mkc.subprj.mk
.if !defined(SUBDIR) && !defined(SUBPRJ)

.PHONY: uninstall
uninstall:
	-rm -f ${UNINSTALLFILES} 2>/dev/null

.PHONY: installdirs
installdirs:
	for d in _ ${INSTALLDIRS:O:u}; do \
		test "$$d" = _ || ${INSTALL} -d "$$d"; \
	done

test:

.endif # SUBDIR

TARGETS+=	all install clean cleandir depend \
		installdirs uninstall errorcheck
${TARGETS}:

.endif # __initialized__
