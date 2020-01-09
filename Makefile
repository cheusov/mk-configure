# Copyright (c) 2014-2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.include "Makefile.inc"

.export CHECK_COMMON_SH_DIR=${.CURDIR}/scripts

.MAIN: all
.DEFAULT:
	@CHECK_COMMON_SH_DIR=${.CURDIR}/scripts; export CHECK_COMMON_SH_DIR; \
	unset ROOT_GROUP; ${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
