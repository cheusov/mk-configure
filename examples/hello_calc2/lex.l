
%{
#include <stdio.h>

#define yylval calc_lval

#include "parser.h"
%}

%option noyywrap

digit		[0-9]
number		{digit}+\.?|{digit}*\.{digit}+
id			[a-zA-Z]+

%%

[ ]				{ /* Skip spaces. */ }
{number}		{ sscanf (yytext, "%lf", &yylval.value); return NUMBER; }
\n|[-+\/*^()]	{ return yytext[0]; }

%%

YYSTYPE calc_lval;
