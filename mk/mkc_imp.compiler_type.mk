# Copyright (c) 2020 by Aleksey Cheusov

.if empty(src_type:Mcxx)
.if !empty(_srcsall:U:M*.cxx) || !empty(_srcsall:U:M*.cpp) || \
    !empty(_srcsall:U:M*.C) || !empty(_srcsall:U:M*.cc) || \
    !empty(_srcsall:U:M*.c\+\+) || \
    !empty(MKC_CHECK_CXX_OPTS:U) || !empty(MKC_CHECK_CXXLD_OPTS:U)
src_type   +=	cxx
LDREAL     ?=	${CXX}
LDFLAGS    +=	${CXXFLAGS.std.${CXXSTD}}
.endif
.endif

.if empty(src_type:Mcc)
.if !empty(_srcsall:U:M*.c) || !empty(_srcsall:U:M*.l) || \
    !empty(_srcsall:U:M*.y) || \
    !empty(MKC_CHECK_HEADERS:U) || !empty(MKC_REQUIRE_HEADERS:U) || \
    !empty(MKC_CHECK_HEADER_FILES:U) || !empty(MKC_REQUIRE_HEADER_FILES:U) || \
    !empty(MKC_CHECK_FUNCLIBS:U) || !empty(MKC_SOURCE_FUNCLIBS:U) || \
    !empty(MKC_REQUIRE_FUNCLIBS:U) || \
    !empty(MKC_CHECK_DEFINES:U) || !empty(MKC_REQUIRE_DEFINES:U) || \
    !empty(MKC_CHECK_TYPES:U) || !empty(MKC_REQUIRE_TYPES:U) || \
    !empty(MKC_CHECK_VARS:U) || !empty(MKC_REQUIRE_VARS:U) || \
    !empty(MKC_CHECK_MEMBERS:U) || !empty(MKC_REQUIRE_MEMBERS:U) || \
    !empty(MKC_CHECK_SIZEOF:U) || \
    !empty(MKC_CHECK_PROTOTYPES:U) || !empty(MKC_REQUIRE_PROTOTYPES:U) || \
    !empty(MKC_CHECK_CC_OPTS:U) || !empty(MKC_CHECK_CCLD_OPTS:U) || \
    !empty(MKC_CHECK_FUNCS1:U) || !empty(MKC_CHECK_FUNCS2:U) || \
    !empty(MKC_CHECK_FUNCS3:U) || !empty(MKC_CHECK_FUNCS4:U) || \
    !empty(MKC_CHECK_FUNCS5:U) || !empty(MKC_CHECK_FUNCS6:U) || \
    !empty(MKC_CHECK_FUNCS7:U) || !empty(MKC_CHECK_FUNCS8:U) || \
    !empty(MKC_CHECK_FUNCS9:U)
src_type  +=	cc
.endif
.endif

.if empty(src_type:Mcc)
.  for c in ${MKC_CHECK_CUSTOM:U} ${MKC_REQUIRE_CUSTOM:U}
.    if empty(MKC_CUSTOM_FN.${c}) || !empty(MKC_CUSTOM_FN.${c}:M*.c)
src_type  +=	cc
.    endif
.  endfor
.endif

.if empty(src_type:Mcxx)
.  for c in ${MKC_CHECK_CUSTOM:U} ${MKC_REQUIRE_CUSTOM:U}
.    if !empty(MKC_CUSTOM_FN.${c}:U:M*.cxx) || !empty(MKC_CUSTOM_FN.${c}:U:M*.cpp) || \
    !empty(MKC_CUSTOM_FN.${c}:U:M*.C) || !empty(MKC_CUSTOM_FN.${c}:U:M*.cc) || \
    !empty(MKC_CUSTOM_FN.${c}:U:M*.c\+\+)
src_type  +=	cxx
.    endif
.  endfor
.endif
