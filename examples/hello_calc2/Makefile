PROG=		calc

SRCS=		lex.l parser.y

YHEADER=	1
YPREFIX=	calc_
LPREFIX=	calc_

MKC_CHECK_BUILTINS=	prog_bison prog_flex

YACC=		${BUILTIN.prog_bison} -y
LEX=		${BUILTIN.prog_flex}

lex.o: parser.h

.include <mkc.configure.mk>

.if empty(BUILTIN.prog_flex)
MKC_ERR_MSG+= "Cannot find flex, good bye!"
.endif

.if empty(BUILTIN.prog_bison)
MKC_ERR_MSG+= "Cannot find bison, good bye!"
.endif

LDADD+=		-lm

.include "test.mk"
.include <mkc.prog.mk>
