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

MKC_COMMON_DEFINES=		-DMKC_COMMON_DEFINES_WORKS_FINE

MKC_COMMON_HEADERS+=	string.h

MKC_SOURCE_FUNCLIBS+=	superfunc1
MKC_SOURCE_FUNCLIBS+=	superfunc2:superlib2

MKC_CHECK_HEADERS+=	sys/time.h string.h
MKC_CHECK_HEADERS+=	bad_dir/bad_header.h bad_header.h
MKC_CHECK_HEADERS+=	include/mkc_test.h

MKC_CHECK_FUNCLIBS+=	strcpy sqrt:m
MKC_CHECK_FUNCLIBS+=	bad_func:bad_lib bad_func

MKC_NOAUTO_FUNCLIBS+=	sqrt:m

MKC_CHECK_DEFINES+=	__BAD_DEFINE__
MKC_CHECK_DEFINES+=	MKC_TEST_DEFINE:include/mkc_test.h

MKC_CHECK_VARS+=	errno:errno.h
MKC_CHECK_VARS+=	bad_var:bar_header
MKC_CHECK_VARS+=	mkc_test_var:include/mkc_test.h

MKC_CHECK_FUNCS2+=	strcmp:string.h
MKC_CHECK_FUNCS3+=	strcpy
MKC_CHECK_FUNCS1+=	bad_func bad_func:bad_header
MKC_CHECK_FUNCS5+=	mkc_test_func:include/mkc_test.h

MKC_CHECK_SIZEOF+=	int long-long void* size_t:string.h
MKC_CHECK_SIZEOF+=	bad_type bad-type:bad_header.h

MKC_CHECK_TYPES+=	size_t:string.h
MKC_CHECK_TYPES+=	bad_type bad-type:bad_header.h

MKC_CHECK_MEMBERS+=	struct-tm.tm_isdst:time.h
MKC_CHECK_MEMBERS+=	struct-sockaddr_in.sin_addr.s_addr:arpa/inet.h:netinet/in.h
MKC_CHECK_MEMBERS+=	bad.member
MKC_CHECK_MEMBERS+=	bad.member:string.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.a:include/mkc_test.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.b.c:include/mkc_test.h

MKC_CHECK_PROGS+=	awk sh megaprog-x34

MKC_CUSTOM_DIR=			${.CURDIR}/custom

MKC_CHECK_CUSTOM+=		custom_check1 custom_check2
MKC_CUSTOM_FN.custom_check2=	my_check2.c

vars+=	HAVE_HEADER.sys_time_h HAVE_HEADER.string_h \
	HAVE_FUNCLIB.strcpy HAVE_FUNCLIB.sqrt \
	HAVE_FUNC2.strcmp.string_h HAVE_FUNC3.strcpy \
	SIZEOF.int SIZEOF.long_long SIZEOF.voidP SIZEOF.size_t.string_h \
	HAVE_TYPE.size_t.string_h \
	HAVE_TYPE.bad_type \
	HAVE_HEADER.bad_header_h HAVE_HEADER.bad_dir_bad_header_h \
	HAVE_FUNCLIB.bad_func HAVE_FUNCLIB.bad_func.bad_lib \
	HAVE_DEFINE.__BAD_DEFINE__ \
	HAVE_FUNC1.bad_func HAVE_FUNC1.bad_func.bad_header \
	SIZEOF.bad_type SIZEOF.bad_type.bad_header_h \
	HAVE_FUNCLIB.superfunc1 HAVE_FUNCLIB.superfunc2.superlib2 \
	HAVE_MEMBER.struct_tm_tm_isdst.time_h \
	HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.netinet_in_h \
	HAVE_MEMBER.bad_member \
	HAVE_MEMBER.bad_member.string_h \
	HAVE_HEADER.include_mkc_test_h \
	HAVE_DEFINE.MKC_TEST_DEFINE.include_mkc_test_h \
	HAVE_FUNC5.mkc_test_func.include_mkc_test_h \
	HAVE_VAR.mkc_test_var.include_mkc_test_h \
	HAVE_MEMBER.struct_mkc_test_t_a.include_mkc_test_h \
	HAVE_MEMBER.struct_mkc_test_t_b_c.include_mkc_test_h \
	\
	CUSTOM.custom_check1 CUSTOM.custom_check2 \
	\
	HAVE_PROG.sh           PROG.sh \
	HAVE_PROG.awk          PROG.awk \
	HAVE_PROG.megaprog-x34 PROG.megaprog-x34 \
	\
	MKC_AUTO_CFLAGS MKC_AUTO_SRCS MKC_AUTO_LDADD

.include <configure.mk>

MKC_AUTO_SRCS:=		${MKC_SRCS}
MKC_AUTO_CFLAGS:=	${MKC_CFLAGS}
MKC_AUTO_LDADD:=	${MKC_LDADD}

HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.netinet_in_h  ?=  \
   ${HAVE_MEMBER.struct_sockaddr_in_sin_addr_s_addr.arpa_inet_h.netinet_in_h}

.if HAVE_FUNCLIB.sqrt || HAVE_FUNCLIB.sqrt.m
HAVE_FUNCLIB.sqrt=	ok
.endif

all:
.for i in ${vars}
	@echo ${i}=${${i}} | \
	sed -e 's|\([^ ]*SIZEOF[^ =]*\)=[0-9][0-9]*|\1=n|g' \
	    -e 's|\([^ ]*PROG[^ =]*\)=[^ =]*bin/|\1=/somewhere/bin/|g'
.endfor
	@echo ''
	@printf "%s\n" "${CPPFLAGS}" | \
		sed "s/^.*-DSYSTEM_.*$$/KNOWN_SYSTEM/"
	@printf "%s\n" "${CPPFLAGS}" | \
		sed 's/^.*\(MKC_COMMON_DEFINES_WORKS_FINE\).*$$/\1/'
