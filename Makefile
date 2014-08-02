# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.MAIN: all
.DEFAULT:
	@unset ROOT_GROUP; ${MAKE} ${MAKEFLAGS} -m ${.CURDIR}/mk -m ${.CURDIR}/features -f main.mk ${.TARGET}
