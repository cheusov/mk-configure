.ifndef __initialized__
__initialized__=1

###########
.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_bsd.own.mk>
#.include <mkc_bsd.obj.mk>
#.include <mkc_bsd.depall.mk>
.MAIN:		all

###########
.PHONY: clean
clean:
	rm -f ${CLEANFILES}

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
.ifndef SUBDIR # skip the following for mkc.subdir.mk

distclean: cleandir
cleandir: clean mkc_cleandir
mkc_cleandir:
	rm -f ${DISTCLEANFILES}

.PHONY: error-check
all : error-check
error-check:
	@for msg in ${MKC_ERR_MSG}; do \
		printf '%s\n' "$$msg"; ex=1; \
	done; exit $$ex

.endif # SUBDIR
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
.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir}
DPLIBDIRS.${_dir}	!= 	cd ${_dir} && ${MAKE} mkc_printobjdir
LDFLAGS+=		-L${DPLIBDIRS.${_dir}}
.endif
.endfor

LDADD+=			${DPLIBS}

###########
.ifndef SUBDIR # skip the following for mkc.subdir.mk

.PHONY: uninstall
uninstall:
	rm -f ${UNINSTALLFILES}

.PHONY: install-dirs
install-dirs:
	${INSTALL} -d ${INSTALLDIRS:O:u}

.endif # SUBDIR

.endif # __initialized__
