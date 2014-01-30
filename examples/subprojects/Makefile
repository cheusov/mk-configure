# main code
SUBDIR +=	libhello1
SUBDIR +=	libhello2
SUBDIR +=	.WAIT
SUBDIR +=	hello

MKC_REQD =	0.11.0

# for regression test only
_THISDIR_ =
.export _THISDIR_

# A simpliest way to build debug and release version is to specify
# appropriate targets like the following.
.PHONY: debug release
debug:
	set -e; \
	COPTS='${COPTS} -O0 -g'; LDFLAGS='${LDFLAGS} -g'; \
	MAKEOBJDIR=${.CURDIR}/debug; MKRELOBJDIR=yes; \
	export COPTS LDFLAGS MAKEOBJDIR MKRELOBJDIR; \
	mkdir -p $$MAKEOBJDIR;\
	${MAKE} ${MAKEFLAGS} all
release:
	set -e; \
	COPTS='${COPTS} -O'; \
	MAKEOBJDIR=${.CURDIR}/release; MKRELOBJDIR=yes; \
	export COPTS MAKEOBJDIR MKRELOBJDIR; \
	mkdir -p $$MAKEOBJDIR;\
	${MAKE} ${MAKEFLAGS} all
.if make(debug) || make(release)
MKCHECKS =	no
.endif

# Alternatively (and better!) one can introduce special variable for
# this purpose like the following
.include <mkc.init.mk> # we need ${MKDIR}

.if defined(BM) # BuildMode
.  if ${BM} == "release"
COPTS      +=	-O
MAKEOBJDIR  =	${.CURDIR}/obj/release
.  elif ${BM} == "debug"
COPTS      +=	-O0 -g
LDFLAGS    +=	-g
MAKEOBJDIR  =	${.CURDIR}/obj/debug
.  elif ${BM} == "profile"
COPTS      +=	-O0 -g -pg
LDFLAGS    +=	-pg
MAKEOBJDIR  =	${.CURDIR}/obj/profile
.  else
.error "Unsupported value of BM"
.  endif
.OBJDIR     =	${MAKEOBJDIR}
MKRELOBJDIR =	yes
fake       !=	${MKDIR} -p ${MAKEOBJDIR}; echo # ${MAKEOBJDIR} must exist
.export COPTS LDFLAGS
.endif # defined(BM)

#
.include "test.mk"
.include "version.mk"
.include <mkc.subdir.mk>
