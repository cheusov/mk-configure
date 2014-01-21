.sinclude "cheusov_local_settings.mk" # for debugging

##################################################
SUBPRJ_DFLT =   custom helpers mk scripts features
SUBPRJ      =	examples tests doc presentation ${SUBPRJ_DFLT}

##################################################
SHRTOUT =		yes

PROJECTNAME =		mk-configure

#
NOEXPORT_VARNAMES =	MKC_CACHEDIR

DIST_TARGETS =		pdf clean-mk clean-scripts mkc_clean

INSTALL      =		${.CURDIR}/scripts/mkc_install
PATH        :=		${OBJDIR_custom}:${OBJDIR_helpers}:${.CURDIR}/helpers:${OBJDIR_scripts}:${.CURDIR}/scripts:${PATH}

.export SHRTOUT INSTALL PATH

##################################################
.PHONY: pdf
pdf: all-presentation
pdf:
	@set -e; cd presentation; \
	${MAKE} ${MAKEFLAGS} clean-garbage; \
	rm -f myprojects.*

##################################################
cleandir:	cleandir-tests cleandir-presentation
clean:		clean-tests clean-presentation
test:		test-tests

##################################################
.include "Makefile.inc"
.include <mkc.mk>
