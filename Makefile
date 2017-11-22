# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.include "Makefile.inc"

.MAIN: all
.DEFAULT:
	@for p in ${generated_scripts}; do cp -p `pwd`/scripts/$$p.in ${.OBJDIR}/$$p; done; \
	CHECK_COMMON_SH_DIR=${.CURDIR}/scripts; export CHECK_COMMON_SH_DIR; \
	PATH="${.OBJDIR}:${PATH}"; export PATH; \
	unset ROOT_GROUP; ${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
