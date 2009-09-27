# Copyright (c) 2009, Aleksey Cheusov <vle@gmx.net>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

###########
.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir:T}
DPLIBDIRS.${_dir:T}	!= 	cd ${.CURDIR}/${_dir} && ${MAKE} ${MAKEFLAGS} mkc_printobjdir
LDFLAGS+=		-L${DPLIBDIRS.${_dir:T}}
.endif
.endfor

.undef DPLIBDIRS

######################################################################
.ifndef __initialized__
__initialized__=1

LDADD+=			${DPLIBS}

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

LDLIBS=		${LDFLAGS} ${LDADD}

###########
.ifndef SUBDIR # skip the following for mkc.subdir.mk

.PHONY: uninstall
uninstall:
	rm -f ${UNINSTALLFILES}

.PHONY: installdirs
installdirs:
	${INSTALL} -d ${INSTALLDIRS:O:u}

test:

.endif # SUBDIR

${TARGETS}:

.endif # __initialized__
