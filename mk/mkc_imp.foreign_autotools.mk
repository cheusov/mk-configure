# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP_FOREIGN_AUTOTOOLS_MK
_MKC_IMP_FOREIGN_AUTOTOOLS_MK := 1

MESSAGE.atconf ?=	@${_MESSAGE} "CONFIGURE:"
MESSAGE.autotools ?=	@${_MESSAGE} "AUTOTOOLS:"

MKC_REQUIRE_PROGS +=	autoreconf

AT_USE_AUTOMAKE ?=	yes
AT_MAKE         ?=	${MAKE}
AT_AUTORECONF_ARGS ?=	-is -f

.if empty(FSRCDIR)
MKC_ERR_MSG +=	"FSRCDIR should not be empty"
.elif empty(FSRCDIR:M/*)
_FSRCDIR = ${.CURDIR}/${FSRCDIR}
.else
_FSRCDIR = ${FSRCDIR}
.endif

.if defined(MAKEOBJDIR) || defined(MAKEOBJDIRPREFIX)
_FOBJDIR =	${.OBJDIR}
.else
_FOBJDIR =	${_FSRCDIR}
.endif

_CONFIGURE_ARGS = --prefix ${PREFIX:Q} --bindir=${BINDIR:Q} \
   --sbindir=${SBINDIR:Q} --libexecdir=${LIBEXECDIR} \
   --sysconfdir=${SYSCONFDIR:Q} --sharedstatedir=${SHAREDSTATEDIR:Q} \
   --localstatedir=${VARDIR:Q} --libdir=${LIBDIR:Q} \
   --includedir=${INCSDIR:Q} --datarootdir=${DATADIR:Q} \
   --infodir=${INFODIR:Q} --localedir=${DATADIR:Q}/locale \
   --mandir=${MANDIR:Q} --docdir=${DATADIR:Q}/doc/${PROJECTNAME} \
   --srcdir=${_FSRCDIR} ${AT_CONFIGURE_ARGS}

_CONFIGURE_ENV = CC=${CC:Q} CFLAGS=${CFLAGS:Q} \
   CXX=${CXX:Q} CXXFLAGS=${CXXFLAGS:Q} \
   CPPFLAGS=${_CPPFLAGS:Q} \
   LDFLAGS=${LDFLAGS:Q} LIBS=${LDADD:Q} CPP=${CPP:Q} ${AT_CONFIGURE_ENV}

_AT_MAKE_ENV = ${DESTDIR:DDESTDIR=${DESTDIR:Q}} ${AT_MAKE_ENV}

realdo_mkgen:
	${MESSAGE.mkgen}
	${_V} ${PROG.autoreconf} ${AT_AUTORECONF_ARGS} ${_FSRCDIR}

realdo_configure: check_mkc_err_msg .WAIT at_do_configure

at_do_configure: .PHONY
	${MESSAGE.atconf}
	${_V} cd ${_FOBJDIR}; env ${_CONFIGURE_ENV} ${_FSRCDIR}/configure ${_CONFIGURE_ARGS}

.for i in all clean cleandir install uninstall
realdo_${i}: at_do_${i}
at_do_${i}: .PHONY
	${MESSAGE.autotools}
	${_V} set -e; \
	cd ${_FOBJDIR}; \
	if test -f Makefile; then \
	    env ${_AT_MAKE_ENV} ${AT_MAKE:S/^$$/false/} ${AT_MAKEFLAGS} \
		MAKE=${AT_MAKE} ${.TARGET:S/^at_do_//:S/cleandir/distclean/}; \
	fi
.endfor

DISTCLEANDIRS  +=	${_FSRCDIR}/autom4te.cache
CLEANDIRFILES +=	${_FSRCDIR}/aclocal.m4 ${_FOBJDIR}/config.log \
   ${_FOBJDIR}/config.status ${_FSRCDIR}/configure ${_FSRCDIR}/depcomp \
   ${_FSRCDIR}/INSTALL ${_FSRCDIR}/install-sh ${_FOBJDIR}/Makefile \
   ${_FSRCDIR}/missing ${_FSRCDIR}/compile ${_FOBJDIR}/stamp-h1

.if ${AT_USE_AUTOMAKE:tl:U} == yes
CLEANDIRFILES    +=	${_FSRCDIR}/Makefile.in
MKC_REQUIRE_PROGS +=	automake
.endif

.endif # _MKC_IMP_FOREIGN_AUTOTOOLS_MK
