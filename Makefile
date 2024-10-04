# Copyright (c) 2014-2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.include "Makefile.inc"

PROJECTNAME =		mk-configure

.export PROJECTNAME=${PROJECTNAME}

.MAIN: all
.DEFAULT:
	@MK_C_PROJECT=`pwd`; export MK_C_PROJECT; LC_ALL=C; export LC_ALL; \
	unset ROOT_GROUP; ${MAKE} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
