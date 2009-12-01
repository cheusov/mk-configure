# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

###########
.ifdef DPLIBDIRS
.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir:T}
DPLIBDIRS.${_dir:T}!= 	cd ${_dir} && ${MAKE} ${MAKEFLAGS} mkc_printobjdir SKIP_CONFIGURE_MK=1
LDFLAGS+=		-L${DPLIBDIRS.${_dir:T}}
.endif
.endfor

.undef DPLIBDIRS

.endif # DPLIBDIRS

######################################################################
.ifndef __initialized__
__initialized__=1

###########
MKC_CACHEDIR?=${.OBJDIR} # directory for cache and intermediate files

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_imp.own.mk>
#.include <mkc_imp.obj.mk>
#.include <mkc_imp.depall.mk>
.MAIN:		all

###########
.if defined(PROG)
SRCS?=		${PROG}.c
.endif

.if defined(LIB)
SRCS?=		${LIB}.c
.endif

.if !empty(SRCS:U:M*.y)
MKC_REQUIRE_PROGS+=			${YACC:[1]}
MKC_PROG.id.${YACC:[1]:S/+/x/g}=	yacc
.endif

.if !empty(SRCS:U:M*.l)
MKC_REQUIRE_PROGS+=			${LEX:[1]}
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
	rm -f ${CLEANFILES}
	rm -rf ${CLEANDIRS}

###########
.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

###########
.PHONY : all mkc_printobjdir
mkc_printobjdir:
	@echo ${.OBJDIR}

###########

distclean: cleandir
cleandir: clean mkc_cleandir
mkc_cleandir:
	rm -f ${DISTCLEANFILES}
	rm -rf ${DISTCLEANDIRS}

.PHONY: error-check
all : error-check
error-check:
	@for msg in ${MKC_ERR_MSG}; do \
		printf '%s\n' "$$msg"; ex=1; \
	done; exit $$ex

###########

# Make sure all of the standard targets are defined, even if they do nothing.
#.PHONY : test all distclean cleandir clean
#test all distclean cleandir clean:

###########
.sinclude <mkc.ver.mk>

.if defined(MKC_REQD) && defined(MKC_VERSION)
_mkc_version_ok!=	mkc_check_version ${MKC_REQD} ${MKC_VERSION}
.if !${_mkc_version_ok}
MKC_ERR_MSG+=	"ERROR: We need mk-configure v.${MKC_REQD} while ${MKC_VERSION} is detected"
.endif
.endif

###########

LDLIBS=		${LDFLAGS} ${LDADD}

###########
.ifndef SUBDIR # skip the following for mkc.subdir.mk

.PHONY: uninstall
uninstall:
	rm -f ${UNINSTALLFILES}

.PHONY: installdirs
installdirs:
	for d in ${INSTALLDIRS:O:u}; do \
		${INSTALL} -d "$$d"; \
	done

test:

.endif # SUBDIR

${TARGETS}:

.endif # __initialized__
