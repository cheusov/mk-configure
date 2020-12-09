# Copyright (c) 2009-2014, Aleksey Cheusov <vle@gmx.net>
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
# See  mk-configure(7) for documentation
#

.include "mkc_imp.compiler_type.mk"

# user defined variables
MKC_SHOW_CACHED     ?= 0          # set it to `1' to show "...(cached)..." lines
MKC_DELETE_TMPFILES ?= 0          # set it to `1' to delete temporary files
MKC_CACHEDIR        ?= ${.OBJDIR} # directory for cache and intermediate files
MKC_COMMON_HEADERS  ?=            # list of headers always #included
MKC_NOCACHE         ?=            # 1 or yes for disabling cache
MKC_CUSTOM_DIR      ?=${.CURDIR}  # directory with custom tests.c
MKC_SOURCE_DIR      ?=${.CURDIR}  # directory with missing strlcat.c etc.
.if !empty(COMPATLIB) && ${COMPATLIB:U} != ${.CURDIR:T}
MKC_NOSRCSAUTO      ?=	1
.else
MKC_NOSRCSAUTO      ?=	0
.endif

#
MKC_SOURCE_FUNCLIBS   ?=
_MKC_SOURCE_FUNCS     :=	${MKC_SOURCE_FUNCLIBS:C/:.*//}

# the following variable is for mkc-configure testing only
_BUILTINSDIR          ?=	${BUILTINSDIR}

# .endif for the next .if is in the end of file
.if ${MKCHECKS:Uno:tl} == "yes"

HAVE_FUNCLIB.main ?=	1

.for i in ${MKC_COMMON_DEFINES.${TARGET_OPSYS}}
CPPFLAGS      +=	${i}
.endfor
.undef MKC_COMMON_DEFINES.${TARGET_OPSYS}
.for i in ${MKC_COMMON_DEFINES}
CPPFLAGS      +=	${i}
.endfor
.undef MKC_COMMON_DEFINES

#
mkc.environ=CC=${CC:Q} CXX=${CXX:Q} CPPFLAGS=${CPPFLAGS:Q}\ ${_cppflags:Q} CFLAGS=${CFLAGS:Q}\ ${_cflags:Q} CXXFLAGS=${CXXFLAGS:Q}\ ${_cxxflags:Q} LDFLAGS=${LDFLAGS:Q}\ ${_ldflags:Q} LDADD=${LDADD:Q}\ ${_ldadd:Q} LEX=${LEX:Q} YACC=${YACC:Q} MKC_CACHEDIR=${MKC_CACHEDIR:Q} MKC_COMMON_HEADERS=${MKC_COMMON_HEADERS:Q} MKC_DELETE_TMPFILES=${MKC_DELETE_TMPFILES:Q} MKC_SHOW_CACHED=${MKC_SHOW_CACHED:Q} MKC_NOCACHE=${MKC_NOCACHE:Q} MKC_VERBOSE=1

######################################################
# checking for builtin checks
.for i in ${MKC_CHECK_BUILTINS} ${MKC_REQUIRE_BUILTINS}
MKC_CUSTOM_FN.${i} ?=	${_BUILTINSDIR}/${i}
MKC_CHECK_CUSTOM   +=	${i}
MKC_REQUIRE_CUSTOM +=	${MKC_REQUIRE_BUILTINS:M${i}}
.endfor

######################################################
# checking for headers
.if defined(MKC_CHECK_HEADER_FILES) || defined(MKC_REQUIRE_HEADER_FILES)
.include "mkc_imp.conf_header_files.mk"
.endif

######################################################
# checking for headers
.if defined(MKC_CHECK_HEADERS) || defined(MKC_REQUIRE_HEADERS)
.include "mkc_imp.conf_headers.mk"
.endif

######################################################
# checking for functions in libraries
.if defined(MKC_CHECK_FUNCLIBS) || defined(MKC_SOURCE_FUNCLIBS) || \
	defined(MKC_REQUIRE_FUNCLIBS)
.include "mkc_imp.conf_funclibs.mk"
.endif

######################################################
# checking for sizeof(xxx)
.ifdef MKC_CHECK_SIZEOF
.include "mkc_imp.conf_sizeof.mk"
.endif

######################################################
# checking for declared #define
.if defined(MKC_CHECK_DEFINES) || defined(MKC_REQUIRE_DEFINES)
.include "mkc_imp.conf_defines.mk"
.endif

######################################################
# checking for declared type
.if defined(MKC_CHECK_TYPES) || defined(MKC_REQUIRE_TYPES)
.include "mkc_imp.conf_types.mk"
.endif

######################################################
# checking for declared variables
.if defined(MKC_CHECK_VARS) || defined(MKC_REQUIRE_VARS)
.include "mkc_imp.conf_vars.mk"
.endif

######################################################
# checking for struct members
.if defined(MKC_CHECK_MEMBERS) || defined(MKC_REQUIRE_MEMBERS)
.include "mkc_imp.conf_members.mk"
.endif

######################################################
# checking for declared functions
.if defined(MKC_CHECK_FUNCS0) || defined(MKC_REQUIRE_FUNCS0) || \
    defined(MKC_CHECK_FUNCS1) || defined(MKC_REQUIRE_FUNCS1) || \
    defined(MKC_CHECK_FUNCS2) || defined(MKC_REQUIRE_FUNCS2) || \
    defined(MKC_CHECK_FUNCS3) || defined(MKC_REQUIRE_FUNCS3) || \
    defined(MKC_CHECK_FUNCS4) || defined(MKC_REQUIRE_FUNCS4) || \
    defined(MKC_CHECK_FUNCS5) || defined(MKC_REQUIRE_FUNCS5) || \
    defined(MKC_CHECK_FUNCS6) || defined(MKC_REQUIRE_FUNCS6) || \
    defined(MKC_CHECK_FUNCS7) || defined(MKC_REQUIRE_FUNCS7) || \
    defined(MKC_CHECK_FUNCS8) || defined(MKC_REQUIRE_FUNCS8) || \
    defined(MKC_CHECK_FUNCS9) || defined(MKC_REQUIRE_FUNCS9)
.include "mkc_imp.conf_funcs.mk"
.endif

######################################################
# custom checks
.if defined(MKC_CHECK_CUSTOM) || defined(MKC_REQUIRE_CUSTOM)
.include "mkc_imp.conf_custom.mk"
.endif

######################################################
# checking for programs
.if defined(MKC_CHECK_PROGS) || defined(MKC_REQUIRE_PROGS)
.include "mkc_imp.conf_progs.mk"
.endif

.if defined(CFLAGS.check) || defined(CXXFLAGS.check) || \
    defined(MKC_CHECK_CC_OPTS) || defined(MKC_CHECK_CXX_OPTS) || \
    defined(MKC_CHECK_CCLD_OPTS) || defined(MKC_CHECK_CXXLD_OPTS)
.include "mkc_imp.conf_opts.mk"
.endif

######################################################
# prototype checks
.if defined(MKC_CHECK_PROTOTYPES) || defined(MKC_REQUIRE_PROTOTYPES)
.include "mkc_imp.conf_prototypes.mk"
.endif

######################################################
.else # MKCHECKS == yes

.endif # MKCHECKS?

######################################################
######################################################
######################################################

.undef MKC_SOURCE_FUNCLIBS
