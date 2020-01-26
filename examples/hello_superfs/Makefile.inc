BINDIR    ?=	${SBINDIR}

.ifdef MICHAEL_MODE
# If MICHAEL_MODE environment variabe is set, everything
# is installed to temporary directory after build and
# uninstalled before cleaning.
# This feature may be useful for development
# and was proposed by Michael Crogan.
PREFIX  =	${TMPPREFIX}
INSTALL =	mkc_install
COPY    =	-ls # symlinks instead of copying/moving
post_all: install
pre_clean: uninstall
.endif
