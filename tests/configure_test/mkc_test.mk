MKC_COMMON_DEFINES.NetBSD=	-DSYSTEM_NetBSD
MKC_COMMON_DEFINES.FreeBSD=	-DSYSTEM_FreeBSD
MKC_COMMON_DEFINES.OpenBSD=	-DSYSTEM_OpenBSD
MKC_COMMON_DEFINES.DragonFly=	-DSYSTEM_DragonFly
MKC_COMMON_DEFINES.MirBSD=	-DSYSTEM_MirBSD
MKC_COMMON_DEFINES.SunOS=	-DSYSTEM_SunOS
MKC_COMMON_DEFINES.Linux=	-DSYSTEM_Linux
MKC_COMMON_DEFINES.Darwin=	-DSYSTEM_Darwin
MKC_COMMON_DEFINES.Interix=	-DSYSTEM_Interix
MKC_COMMON_DEFINES.QNX=		-DSYSTEM_QNX
MKC_COMMON_DEFINES.HP-UX=	-DSYSTEM_HPUX
MKC_COMMON_DEFINES.OSF1=	-DSYSTEM_OSF1
MKC_COMMON_DEFINES.Cygwin=	-DSYSTEM_CYGWIN
MKC_COMMON_DEFINES.Haiku=	-DSYSTEM_Haiku
MKC_COMMON_DEFINES.IRIX64=	-DSYSTEM_IRIX64

MKC_COMMON_DEFINES=		-DMKC_COMMON_DEFINES_WORKS_FINE
MKC_COMMON_DEFINES+=		-D__JUSTATEST

MKC_COMMON_HEADERS+=		string.h

MKC_SOURCE_FUNCLIBS+=	superfunc1
MKC_SOURCE_FUNCLIBS+=	superfunc2:superlib2

MKC_CHECK_HEADERS+=	sys/time.h string.h stdlib.h,unistd.h
MKC_CHECK_HEADERS+=	bad_dir/bad_header.h bad_header.h
MKC_CHECK_HEADERS+=	include/mkc_test.h

MKC_CHECK_HEADER_FILES+=	sys/time.h string.h stdlib.h,unistd.h
MKC_CHECK_HEADER_FILES+=	bad_dir/bad_header.h bad_header.h
MKC_CHECK_HEADER_FILES+=	include/mkc_test.h

MKC_REQUIRE_HEADERS+=		stdio.h
MKC_REQUIRE_HEADER_FILES+=	stdio.h

MKC_CHECK_FUNCLIBS+=	strcpy sqrt:m
MKC_CHECK_FUNCLIBS+=	bad_func:bad_lib bad_func

MKC_NOAUTO_FUNCLIBS+=	sqrt:m

MKC_CHECK_DEFINES+=	__BAD_DEFINE__
MKC_CHECK_DEFINES+=	MKC_TEST_DEFINE:include/mkc_test.h
MKC_CHECK_DEFINES+=	EINVAL:stdio.h,errno.h

MKC_REQUIRE_DEFINES+=	__JUSTATEST

MKC_CHECK_VARS+=	errno:errno.h
MKC_CHECK_VARS+=	bad_var:bar_header
MKC_CHECK_VARS+=	mkc_test_var:string.h,include/mkc_test.h

MKC_REQUIRE_VARS+=	mkc_test_var2:include/mkc_test.h

MKC_CHECK_FUNCS2+=	strcmp:stdlib.h,string.h
MKC_CHECK_FUNCS3+=	strcpy
MKC_CHECK_FUNCS1+=	bad_func bad_func:stdlib.h,bad_header
MKC_CHECK_FUNCS5+=	mkc_test_func:stdlib.h,include/mkc_test.h

MKC_CHECK_FUNCS1+=	bad_func1:string.h
MKC_FUNC_OR_DEFINE.bad_func1 = yes

MKC_CHECK_FUNCS2+=	strtok:string.h
MKC_FUNC_OR_DEFINE.strtok = yes

MKC_REQUIRE_FUNCS0+=	mkc_test_func2:include/mkc_test.h

MKC_CHECK_SIZEOF+=	int long-long void* size_t:stdlib.h,unistd.h,string.h
MKC_CHECK_SIZEOF+=	bad_type bad-type:bad_header.h

MKC_CHECK_TYPES+=	size_t:string.h
MKC_CHECK_TYPES+=	bad_type bad-type:bad_header.h
MKC_CHECK_TYPES+=	time_t:stddef.h,time.h

MKC_REQUIRE_TYPES+=	size_t:stdlib.h

MKC_CHECK_MEMBERS+=	struct-tm.tm_isdst:string.h,time.h
MKC_CHECK_MEMBERS+=	struct-sockaddr_in.sin_addr.s_addr:arpa/inet.h:netinet/in.h
MKC_CHECK_MEMBERS+=	bad.member
MKC_CHECK_MEMBERS+=	bad.member:string.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.a:include/mkc_test.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.b.c:include/mkc_test.h

MKC_REQUIRE_MEMBERS+=	struct-mkc_test_t.d:include/mkc_test.h

MKC_CHECK_PROGS+=	awk sh megaprog-x34

MKC_CUSTOM_DIR=		${.CURDIR}/custom

MKC_CHECK_CUSTOM+=	custom_check1 custom_check2 custom_check2_link \
   custom_check5 custom_check5_link custom_check5_noauto

MKC_CUSTOM_FN.custom_check2        =	my_check2.c
MKC_CUSTOM_FN.custom_check2_link   =	my_check2.c
MKC_CUSTOM_LINK.custom_check2_link =	YES

MKC_CUSTOM_FN.custom_check5        =	my_check5.c
MKC_CUSTOM_FN.custom_check5_link   =	my_check5.c
MKC_CUSTOM_LINK.custom_check5_link =	YES

MKC_CUSTOM_FN.custom_check5_noauto     =	my_check5.c
MKC_CUSTOM_NOAUTO.custom_check5_noauto =	yes
MKC_CUSTOM_CACHE.custom_check5_noauto  =	cache2

MKC_REQUIRE_CUSTOM+=	custom_check3

MKC_CHECK_PROTOTYPES =	strstr_ok strstr_bad function_absent
MKC_PROTOTYPE_FUNC.strstr_ok  = char* strstr   (const  char*,  const char* )
MKC_PROTOTYPE_FUNC.strstr_bad = char* strstr(const char*, const char*, int lalala)
MKC_PROTOTYPE_FUNC.function_absent = int absent_function(int lalala)
MKC_PROTOTYPE_HEADERS.strstr_ok  = string.h
MKC_PROTOTYPE_HEADERS.strstr_bad = string.h
MKC_PROTOTYPE_HEADERS.function_absent = string.h

MKC_CHECK_CC_OPTS =	-DMACRO=zzz --zzz
MKC_CHECK_CCLD_OPTS =	-DMACRO=zzz --zzz
MKC_CHECK_CXX_OPTS =	-DMACRO=zzz --zzz
MKC_CHECK_CXXLD_OPTS =	-DMACRO=zzz --zzz

vars+=	HAVE_HEADER.sys_time_h HAVE_HEADER.string_h HAVE_HEADER.unistd_h \
	HAVE_HEADER_FILE.sys_time_h HAVE_HEADER_FILE.string_h \
	HAVE_HEADER_FILE.unistd_h \
	HAVE_FUNCLIB.strcpy HAVE_FUNCLIB.sqrt \
	HAVE_FUNC2.strcmp.string_h HAVE_FUNC3.strcpy \
	SIZEOF.int SIZEOF.long_long SIZEOF.voidP SIZEOF.size_t.string_h \
	HAVE_TYPE.size_t.string_h \
	HAVE_TYPE.bad_type HAVE_TYPE.time_t.time_h \
	HAVE_HEADER.bad_header_h HAVE_HEADER.bad_dir_bad_header_h \
	HAVE_HEADER_FILE.bad_header_h HAVE_HEADER_FILE.bad_dir_bad_header_h \
	HAVE_FUNCLIB.bad_func HAVE_FUNCLIB.bad_func.bad_lib \
	HAVE_DEFINE.__BAD_DEFINE__ \
	HAVE_FUNC1.bad_func HAVE_FUNC1.bad_func.bad_header \
	HAVE_FUNC1.bad_func1.string_h \
	HAVE_FUNC2.strtok.string_h \
	SIZEOF.bad_type SIZEOF.bad_type.bad_header_h \
	HAVE_FUNCLIB.superfunc1 HAVE_FUNCLIB.superfunc2.superlib2 \
	HAVE_MEMBER.struct_tm_tm_isdst.time_h \
	HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.netinet_in_h \
	HAVE_MEMBER.bad_member \
	HAVE_MEMBER.bad_member.string_h \
	HAVE_HEADER.include_mkc_test_h \
	HAVE_HEADER_FILE.include_mkc_test_h \
	HAVE_DEFINE.MKC_TEST_DEFINE.include_mkc_test_h \
	HAVE_DEFINE.EINVAL.errno_h \
	HAVE_FUNC5.mkc_test_func.include_mkc_test_h \
	HAVE_VAR.mkc_test_var.include_mkc_test_h \
	HAVE_MEMBER.struct_mkc_test_t_a.include_mkc_test_h \
	HAVE_MEMBER.struct_mkc_test_t_b_c.include_mkc_test_h \
	HAVE_PROTOTYPE.strstr_ok HAVE_PROTOTYPE.strstr_bad HAVE_PROTOTYPE.function_absent \
	HAVE_CC_OPT.-DMACRO_zzz HAVE_CXX_OPT.-DMACRO_zzz \
	HAVE_CCLD_OPT.-DMACRO_zzz HAVE_CXXLD_OPT.-DMACRO_zzz \
	HAVE_CC_OPT.--zzz HAVE_CXX_OPT.--zzz \
	HAVE_CCLD_OPT.--zzz HAVE_CXXLD_OPT.--zzz \
	\
	CUSTOM.custom_check1 CUSTOM.custom_check2 CUSTOM.custom_check2_link \
	CUSTOM.custom_check5 CUSTOM.custom_check5_link CUSTOM.custom_check5_noauto \
	\
	HAVE_PROG.sh           PROG.sh \
	HAVE_PROG.awk          PROG.awk \
	HAVE_PROG.megaprog-x34 PROG.megaprog-x34 \
	\
	MKC_AUTO_CPPFLAGS MKC_AUTO_SRCS MKC_AUTO_LDADD

.include <mkc.configure.mk>

HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.netinet_in_h  ?=  \
   ${HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.arpa_inet_h.netinet_in_h}

.if HAVE_FUNCLIB.sqrt || HAVE_FUNCLIB.sqrt.m
HAVE_FUNCLIB.sqrt=	ok
.endif

all:
.for i in ${vars}
	@echo ${i}=${${i}} | \
	sed -e 's|\([^ ]*SIZEOF[^ =]*\)=[0-9][0-9]*|\1=n|g' \
	    -e 's|\([^ ]*PROG[^ =]*\)=[^ =]*bin/|\1=/somewhere/bin/|g' \
	    -e '/^MKC_AUTO_SRCS=/ s|/[^ ]*/||g'
.endfor
	@echo ''
	@printf "%s\n" "${CPPFLAGS}" | \
		sed "s/^.*-DSYSTEM_.*$$/KNOWN_SYSTEM/"
	@printf "%s\n" "${CPPFLAGS}" | \
		sed 's/^.*\(MKC_COMMON_DEFINES_WORKS_FINE\).*$$/\1/'
	@ls -1 _mkc_* | grep -E 'cache2|cc_opt|cxx_opt|ccld_opt|cxxld_opt' | sort

.include <mkc.mk>
