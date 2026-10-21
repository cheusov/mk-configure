MKC_CHECK_PROTOTYPES =	execve_ok execve_bad function_absent
MKC_PROTOTYPE_FUNC.execve_ok  = int  execve (  const  char  *,  char  *  const *, char * const *   )
MKC_PROTOTYPE_FUNC.execve_bad = int execve(const char*, const char*, int lalala)
MKC_PROTOTYPE_FUNC.function_absent = int absent_function(int lalala)
MKC_PROTOTYPE_HEADERS.execve_ok  = unistd.h
MKC_PROTOTYPE_HEADERS.execve_bad = unistd.h
MKC_PROTOTYPE_HEADERS.function_absent = string.h

vars              :=	${MKC_CHECK_PROTOTYPES:C/^.*,//:S,/,_,g:S/,/./g:S/./_/g:S/^/HAVE_PROTOTYPE./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
