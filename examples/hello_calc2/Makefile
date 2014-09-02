PROG =		calc
SRCS =		lex.l parser.y

DPSRCS  =	lex.c parser.c parser.h

YHEADER =	1
YPREFIX =	calc_
LPREFIX =	calc_

MKC_CHECK_BUILTINS =	prog_bison prog_flex

MKC_FEATURES +=	libm

lex.o: parser.h

.include <mkc.configure.mk>

YACC   =	${"${BUILTIN.prog_bison}" != "":?${BUILTIN.prog_bison} -y:}
LEX    =	${BUILTIN.prog_flex}
LEXLIB =	#-lfl

.if empty(BUILTIN.prog_flex)
MKC_ERR_MSG += "Cannot find flex, good bye!"
.endif

.if empty(BUILTIN.prog_bison)
MKC_ERR_MSG += "Cannot find bison, good bye!"
.endif

.include "test.mk"
.include <mkc.prog.mk>
