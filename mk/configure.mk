# Copyright (c) 2009-2013, Aleksey Cheusov <vle@gmx.net>
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

# user defined variables
MKC_SHOW_CACHED     ?= 0          # set it to `1' to show "...(cached)..." lines
MKC_DELETE_TMPFILES ?= 0          # set it to `1' to delete temporary files
MKC_CACHEDIR        ?= ${.OBJDIR} # directory for cache and intermediate files
MKC_COMMON_HEADERS  ?=            # list of headers always #included
MKC_NOCACHE         ?=            # 1 or yes for disabling cache
MKC_CUSTOM_DIR      ?=${.CURDIR}  # directory with custom tests.c
MKC_SOURCE_DIR      ?=${.CURDIR}  # directory with missing strlcat.c etc.

#
MKC_SOURCE_FUNCLIBS   ?=
_MKC_SOURCE_FUNCS      =	${MKC_SOURCE_FUNCLIBS:C/:.*//}

# .endif for the next .if is in the end of file
.if ${MKCHECKS:Uno:tl} == "yes"

HAVE_FUNCLIB.main ?=	1

.if defined(MKC_COMMON_DEFINES.${TARGET_OPSYS})
CPPFLAGS +=		${MKC_COMMON_DEFINES.${TARGET_OPSYS}}
.endif
.if defined(MKC_COMMON_DEFINES)
CPPFLAGS +=		${MKC_COMMON_DEFINES}
.endif

#
_MKC_CPPFLAGS :=	${CPPFLAGS}
_MKC_CFLAGS   :=	${CFLAGS}
_MKC_CXXFLAGS :=	${CXXFLAGS}
_MKC_FFLAGS   :=	${FFLAGS}
_MKC_LDFLAGS  :=	${LDFLAGS}
_MKC_LDADD    :=	${LDADD}

mkc.environ=CC='${CC}' CXX='${CXX}' FC='${FC}' CPPFLAGS='${_MKC_CPPFLAGS}' CFLAGS='${_MKC_CFLAGS}' CXXFLAGS='${_MKC_CXXFLAGS}' FFLAGS='${_MKC_FFLAGS}' LDFLAGS='${_MKC_LDFLAGS}' LDADD='${_MKC_LDADD}' LEX='${LEX}' YACC='${YACC}' MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_COMMON_HEADERS='${MKC_COMMON_HEADERS}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1

######################################################
# checking for builtin checks
.for i in ${MKC_CHECK_BUILTINS} ${MKC_REQUIRE_BUILTINS}
MKC_CUSTOM_FN.${i} ?=	${BUILTINSDIR}/${i:S/endianess/endianness/}
MKC_CHECK_CUSTOM   +=	${i}
MKC_REQUIRE_CUSTOM +=	${MKC_REQUIRE_BUILTINS:M${i}}
.endfor

######################################################
# checking for headers
.for h in ${MKC_CHECK_HEADERS} ${MKC_REQUIRE_HEADERS}
.if !defined(HAVE_HEADER.${h:S|.|_|g:S|/|_|g})
HAVE_HEADER.${h:S|.|_|g:S|/|_|g}   !=   env ${mkc.environ} mkc_check_header ${h}
.endif
.if ${HAVE_HEADER.${h:S|.|_|g:S|/|_|g}}
.if empty(MKC_REQUIRE_HEADERS:U:M${h})
MKC_CFLAGS  +=	-DHAVE_HEADER_${h:tu:S|.|_|g:S|/|_|g}=${HAVE_HEADER.${h:S|.|_|g:S|/|_|g}}
.endif
.elif !empty(MKC_REQUIRE_HEADERS:U:M${h})
_fake   !=   env ${mkc.environ} mkc_check_header -d ${h} && echo
MKC_ERR_MSG +=	"ERROR: cannot find header ${h}"
.endif
.endfor

.undef MKC_CHECK_HEADERS
.undef MKC_REQUIRE_HEADERS

######################################################
# checking for functions in libraries
.for f in ${MKC_CHECK_FUNCLIBS:U} ${MKC_SOURCE_FUNCLIBS:U} ${MKC_REQUIRE_FUNCLIBS:U}
.if !defined(HAVE_FUNCLIB.${f:S/:/./g})
HAVE_FUNCLIB.${f:S/:/./g} !=	env ${mkc.environ} mkc_check_funclib ${f:S/:/ /g}
.endif
.if !defined(HAVE_FUNCLIB.${f:C/:.*//})
HAVE_FUNCLIB.${f:C/:.*//} !=	env ${mkc.environ} mkc_check_funclib ${f:C/:.*//}
.endif
.if ${HAVE_FUNCLIB.${f:C/:.*//}} != ${HAVE_FUNCLIB.${f:S/:/./g}}
.if empty(MKC_NOAUTO_FUNCLIBS:U:S/:/./g:M${f:S/:/./g}) && empty(MKC_NOAUTO_FUNCLIBS:U:M1) && ${HAVE_FUNCLIB.${f:S/:/./g}} && !${HAVE_FUNCLIB.${f:C/:.*//}}
MKC_LDADD +=	-l${f:C/^.*://}
.endif
.endif
.if !${HAVE_FUNCLIB.${f:S/:/./g}} && !${HAVE_FUNCLIB.${f:C/:.*//}} && !empty(_MKC_SOURCE_FUNCS:M${f:C/:.*//})
MKC_SRCS +=	${MKC_SOURCE_DIR.${f:C/:.*//}.c:U${MKC_SOURCE_DIR}}/${f:C/:.*//}.c
.endif
.endfor # f

.for f in ${MKC_REQUIRE_FUNCLIBS:U}
.if !${HAVE_FUNCLIB.${f:S/:/./g}} && !${HAVE_FUNCLIB.${f:C/:.*//}}
_fake   !=   env ${mkc.environ} mkc_check_funclib -d ${f:C/:.*//} && echo
_fake   !=   env ${mkc.environ} mkc_check_funclib -d ${f:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find function ${f}"
.endif
.endfor # f

.undef MKC_CHECK_FUNCLIBS
.undef MKC_REQUIRE_FUNCLIBS

######################################################
# checking for sizeof(xxx)
.for t in ${MKC_CHECK_SIZEOF:U}
.if !defined(SIZEOF.${t:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g})
SIZEOF.${t:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g}   !=   env ${mkc.environ} mkc_check_sizeof ${t:S/:/ /g}
.endif
.if ${SIZEOF.${t:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g}} != failed
MKC_CFLAGS  +=  -DSIZEOF_${t:S/-/_/g:S| |_|g:S|*|P|g:S|:|_|g:S|.|_|g:tu}=${SIZEOF.${t:S|.|_|g:S|-|_|g:S|*|P|g:S|/|_|g:S|:|.|g}}
.endif
.endfor

.undef MKC_CHECK_SIZEOF

######################################################
# checking for declared #define
.for d in ${MKC_CHECK_DEFINES:U} ${MKC_REQUIRE_DEFINES:U}
.if !defined(HAVE_DEFINE.${d:S/./_/g:S/:/./g:S|/|_|g})
HAVE_DEFINE.${d:S/./_/g:S/:/./g:S|/|_|g}   !=   env ${mkc.environ} mkc_check_decl define ${d:S/:/ /g}
.endif
.if ${HAVE_DEFINE.${d:S/./_/g:S/:/./g:S|/|_|g}}
.if empty(MKC_REQUIRE_DEFINES:U:M${d})
MKC_CFLAGS  +=	-DHAVE_DEFINE_${d:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.endif
.endif
.endfor

.for d in ${MKC_REQUIRE_DEFINES:U}
.if !${HAVE_DEFINE.${d:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d define ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of define ${d}"
.endif
.endfor

.undef MKC_CHECK_DEFINES
.undef MKC_REQUIRE_DEFINES

######################################################
# checking for declared type
.for t in ${MKC_CHECK_TYPES:U} ${MKC_REQUIRE_TYPES:U}
.if !defined(HAVE_TYPE.${t:S/./_/g:S/:/./g:S|/|_|g})
HAVE_TYPE.${t:S/./_/g:S/:/./g:S|/|_|g}   !=   env ${mkc.environ} mkc_check_decl type ${t:S/:/ /g}
.endif
.if ${HAVE_TYPE.${t:S/./_/g:S/:/./g:S|/|_|g}}
.if empty(MKC_REQUIRE_TYPES:U:M${t})
MKC_CFLAGS  +=	-DHAVE_TYPE_${t:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.endif
.endif
.endfor

.for t in ${MKC_REQUIRE_TYPES:U}
.if !${HAVE_TYPE.${t:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d type ${t:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of type ${t}"
.endif
.endfor

.undef MKC_CHECK_TYPES
.undef MKC_REQUIRE_TYPES

######################################################
# checking for declared variables
.for d in ${MKC_CHECK_VARS:U} ${MKC_REQUIRE_VARS:U}
.if !defined(HAVE_VAR.${d:S/./_/g:S/:/./g:S|/|_|g})
HAVE_VAR.${d:S/./_/g:S/:/./g:S|/|_|g}   !=   env ${mkc.environ} mkc_check_decl variable ${d:S/:/ /g}
.endif
.if ${HAVE_VAR.${d:S/./_/g:S/:/./g:S|/|_|g}}
.if empty(MKC_REQUIRE_VARS:U:M${d})
MKC_CFLAGS  +=	-DHAVE_VAR_${d:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.endif
.endif
.endfor

.for d in ${MKC_REQUIRE_VARS:U}
.if !${HAVE_VAR.${d:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d variable ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of variable ${d}"
.endif
.endfor

.undef MKC_CHECK_VARS
.undef MKC_REQUIRE_VARS

######################################################
# checking for struct members
.for m in ${MKC_CHECK_MEMBERS:U} ${MKC_REQUIRE_MEMBERS:U}
.if !defined(HAVE_MEMBER.${m:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g})
HAVE_MEMBER.${m:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g}   !=   env ${mkc.environ} mkc_check_decl member ${m:S/:/ /g}
.endif
.if ${HAVE_MEMBER.${m:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g}}
.if empty(MKC_REQUIRE_MEMBERS:U:M${m})
MKC_CFLAGS  +=	-DHAVE_MEMBER_${m:tu:S/:/_/g:S/./_/g:S|/|_|g:S/-/_/g}=1
.endif
.endif
.endfor

.for m in ${MKC_REQUIRE_MEMBERS:U}
.if !${HAVE_MEMBER.${m:S/./_/g:S/:/./g:S|/|_|g:S/-/_/g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d member ${m:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find member ${m}"
.endif
.endfor

.undef MKC_CHECK_MEMBERS
.undef MKC_REQUIRE_MEMBERS

######################################################
# checking for declared functions
.for n in 0 1 2 3 4 5 6 7 8 9

.for d in ${MKC_CHECK_FUNCS${n}:U} ${MKC_REQUIRE_FUNCS${n}:U}
.if !defined(HAVE_FUNC${n}.${d:S/./_/g:S/:/./g:S|/|_|g})
HAVE_FUNC${n}.${d:S/./_/g:S/:/./g:S|/|_|g}   !=   env ${mkc.environ} mkc_check_decl func${n} ${d:S/:/ /g}
.endif
.if ${HAVE_FUNC${n}.${d:S/./_/g:S/:/./g:S|/|_|g}}
.if empty(MKC_REQUIRE_FUNCS${n}:U:M${d})
MKC_CFLAGS  +=	-DHAVE_FUNC${n}_${d:tu:S/:/_/g:S/./_/g:S|/|_|g}=1
.endif
.endif
.endfor # d

.for d in ${MKC_REQUIRE_FUNCS${n}:U}
.if !${HAVE_FUNC${n}.${d:S/./_/g:S/:/./g:S|/|_|g}}
_fake   !=   env ${mkc.environ} mkc_check_decl -d func${n} ${d:S/:/ /g} && echo
MKC_ERR_MSG +=	"ERROR: cannot find declaration of function ${d}"
.endif
.endfor # d

MKC_CHECK_FUNCS${n}   := # workaround for buggy bmake-20110606
MKC_REQUIRE_FUNCS${n} := # workaround for buggy bmake-20110606

.undef MKC_CHECK_FUNCS${n}
.undef MKC_REQUIRE_FUNCS${n}

.endfor # n

######################################################
# custom checks
.for c in ${MKC_CHECK_CUSTOM} ${MKC_REQUIRE_CUSTOM}
.if !defined(CUSTOM.${c})
.if !defined(MKC_CUSTOM_FN.${c})
MKC_CUSTOM_FN.${c} =	${c}.c
.endif
.if empty(MKC_CUSTOM_FN.${c}:M/*)
MKC_CUSTOM_FN.${c} :=	${MKC_CUSTOM_DIR}/${MKC_CUSTOM_FN.${c}}
.endif
.if ${c} == "endianess"
.warning "endianess test deprecated; use endianness instead"
.endif
CUSTOM.${c} !=		env ${mkc.environ} mkc_check_custom ${MKC_CUSTOM_FN.${c}}
.endif
.if !empty(CUSTOM.${c}) && ${CUSTOM.${c}} != 0
.if empty(MKC_REQUIRE_CUSTOM:U:M${c})
MKC_CFLAGS  +=		-DCUSTOM_${c:tu}=${CUSTOM.${c}}
.endif
.endif
.endfor

.for c in ${MKC_REQUIRE_CUSTOM}
.if empty(CUSTOM.${c}) || ${CUSTOM.${c}} == 0
_fake   !=   env ${mkc.environ} mkc_check_custom -d ${MKC_CUSTOM_FN.${c}} && echo
MKC_ERR_MSG +=		"ERROR: custom test ${c} failed"
.endif
.endfor

.for c in ${MKC_CHECK_BUILTINS} 
BUILTIN.${c} =		${CUSTOM.${c}}
.endfor

######################################################
# checking for programs
.for p in ${MKC_CHECK_PROGS} ${MKC_REQUIRE_PROGS}
p_      :=	${p}
prog_id :=	${MKC_PROG.id.${p:S|+|x|g}:U${p}:S|/|_|g}
.ifdef PROG.${prog_id}
.elif !empty(p_:M/*)
PROG.${prog_id} = ${p}
.else
PROG.${prog_id} != env ${mkc.environ} mkc_check_prog -i '${prog_id}' '${p}'
.endif # !defined(PROG.${prog_id})
.ifndef HAVE_PROG.${prog_id}
.if !empty(PROG.${prog_id}) && exists(${PROG.${prog_id}})
HAVE_PROG.${prog_id} =		1
.else
HAVE_PROG.${prog_id} =		0
.endif
.endif # ifndef HAVE_PROG.${prog_id}

.if !${HAVE_PROG.${prog_id}} && !empty(MKC_REQUIRE_PROGS:U1:M${p})
_fake   !=   env ${mkc.environ} mkc_check_prog -d -i '${prog_id}' '${p}' && echo
MKC_ERR_MSG +=	"ERROR: cannot find program ${p}"
.endif
.endfor # p

.undef MKC_CHECK_PROGS
.undef MKC_REQUIRE_PROGS

.undef MKC_CHECK_CUSTOM
.undef MKC_REQUIRE_CUSTOM

######################################################
# prototype checks
.for p in ${MKC_CHECK_PROTOTYPES} ${MKC_REQUIRE_PROTOTYPES}
.if !defined(HAVE_PROTOTYPE.${p})
HAVE_PROTOTYPE.${p} !=	env ${mkc.environ} mkc_check_decl prototype \
	${MKC_PROTOTYPE_FUNC.${p}:Q} ${MKC_PROTOTYPE_HEADERS.${p}}
.endif # !defined(HAVE_PROTOTYPE.${p})
.if ${HAVE_PROTOTYPE.${p}}
MKC_CFLAGS  +=	-DHAVE_PROTOTYPE_${p:tu}=1
.elif !empty(MKC_REQUIRE_PROTOTYPES:U:M${p})
_fake       !=	env ${mkc.environ} mkc_check_decl -d prototype \
	${MKC_PROTOTYPE_FUNC.${p}:Q} ${MKC_PROTOTYPE_HEADERS.${p}}; echo
MKC_ERR_MSG +=		"ERROR: prototype test ${p} failed"
.endif # ${PROTOTYPE.${p}}
.endfor # p

.undef MKC_CHECK_PROTOTYPES
.undef MKC_REQUIRE_PROTOTYPES

######################################################
# final assignment
.include <mkc_imp.conf-final.mk>

.else # MKCHECKS == yes

.for i in ${_MKC_SOURCE_FUNCS}
SRCS +=	${i} # for changing CLEANFILES
.endfor

.endif # MKCHECKS?

######################################################
######################################################
######################################################

.undef MKC_SOURCE_FUNCLIBS
