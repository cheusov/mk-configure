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

LDADD+=			${DPLIBS}

###########
.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_imp.own.mk>
#.include <mkc_imp.obj.mk>
#.include <mkc_imp.depall.mk>
.MAIN:		all

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
.PHONY : mkc_printobjdir
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
