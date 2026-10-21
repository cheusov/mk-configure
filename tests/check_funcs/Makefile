MKC_COMMON_HEADERS +=		string.h

MKC_CHECK_FUNCS2   +=	strcmp:stdlib.h,string.h
MKC_CHECK_FUNCS3   +=	strcpy
MKC_CHECK_FUNCS1   +=	bad_func bad_func:stdlib.h,bad_header
MKC_CHECK_FUNCS5   +=	mkc_test_func:stdlib.h,include/mkc_test.h

MKC_CHECK_FUNCS1   +=	bad_func1:string.h
MKC_FUNC_OR_DEFINE.bad_func1 = yes

MKC_CHECK_FUNCS2   +=	strtok:string.h
MKC_FUNC_OR_DEFINE.strtok = yes

MKC_CHECK_FUNCS0   +=	mkc_test_func2:include/mkc_test.h

CPPFLAGS           +=	-I..

.for n in 0 1 2 3 4 5
vars               +=	${MKC_CHECK_FUNCS${n}:C/:.*,/:/:S,/,_,g:S/.h/_h/g:S/:/./g:S/^/HAVE_FUNC${n}./g}
.endfor

vars := ${vars}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
