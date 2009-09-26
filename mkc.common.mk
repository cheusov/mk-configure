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

######################################################################
.if !defined(NOMKC_ATALL) || empty(NOMKC_ATALL:M[Yy][Ee][Ss])

######################################################################
.include <mkc_bsd.own.mk>

######################################################################
.if !defined(NOMKC_INSTDIRS) || empty(NOMKC_INSTDIRS:M[Yy][Ee][Ss])
.if make(install-dirs)

NOMKC_INSTDIRS:=	yes

# install-dirs target

.if defined(INCS)
_MKC_INSTALLDIRS+=	${DESTDIR}${INCSDIR}
.endif

.if defined(PROG)
_MKC_INSTALLDIRS+=	${DESTDIR}${BINDIR}
.endif

.if defined(SCRIPTS)
.for i in ${SCRIPTS}
_MKC_INSTALLDIRS+=	${DESTDIR}${SCRIPTSDIR_${i}:U${SCRIPTSDIR}}
.endfor
.endif

.if defined(FILES)
.for i in ${FILES}
_MKC_INSTALLDIRS+=	${DESTDIR}${FILESDIR_${i}:U${FILESDIR}}
.endfor
.endif

.if defined(LIB)
_MKC_INSTALLDIRS+=	${DESTDIR}${LIBDIR}
.endif

.if defined(MAN)
.if defined(MKMAN) && !empty(MKMAN:M[Yy][Ee][Ss])
.for i in ${MAN:E:O:u}
_MKC_INSTALLDIRS+=	${DESTDIR}${MANDIR}/man${i}
.if defined(MKCATPAGES) && !empty(MKCATPAGES:M[Yy][Ee][Ss])
_MKC_INSTALLDIRS+=	${DESTDIR}${MANDIR}/cat${i}
.endif # MKCATPAGES
.if defined(MKHTML) && !empty(MKHTML:M[Yy][Ee][Ss])
_MKC_INSTALLDIRS+=	${DESTDIR}${HTMLDIR}/html${i}
.endif # MKHTML
.endfor # i
.endif # MKMAN
.endif # MAN

.if defined(TEXINFO)
.if !defined(MKINFO) || empty(MKINFO:M[Nn][Oo])
_MKC_INSTALLDIRS+=	${DESTDIR}${INFODIR}
.endif # MKINFO
.endif # TEXINFO

.if defined(LINKS)
.for i j in ${LINKS}
_MKC_INSTALLDIRS+=	${DESTDIR}${j:H}
.endfor # i j
.endif # LINKS

.if defined(SYMLINKS)
.for i j in ${SYMLINKS}
_MKC_INSTALLDIRS+=	${DESTDIR}${j:H}
.endfor # i j
.endif # LINKS

.PHONY: install-dirs
install-dirs:
.for d in ${_MKC_INSTALLDIRS:O:u}
	${INSTALL} -d "${d}"
.endfor

.endif # make(install-dirs)
.endif # NOMKC_INSTDIRS

######################################################################

.endif # NOMKC_ATALL
