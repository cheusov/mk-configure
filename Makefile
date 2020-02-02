# Copyright (c) 2014-2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.include "Makefile.inc"

PROJECTNAME =		mk-configure

.export CHECK_COMMON_SH_DIR=${.CURDIR}/scripts
.export PROJECTNAME=${PROJECTNAME}

.MAIN: all
.DEFAULT:
	@CHECK_COMMON_SH_DIR=${.CURDIR}/scripts; export CHECK_COMMON_SH_DIR; \
	BUILTINSDIR=${.CURDIR}/builtins; export BUILTINSDIR; \
	MK_C_PROJECT=1; export MK_C_PROJECT; \
	unset ROOT_GROUP; ${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
