%{
#include <ctype.h>
#include <stdio.h>

#define YYSTYPE int
%}

%token NUMBER
%left  '+' '-'
%right '*' '/'

%%

lines : lines expr '\n' { printf ("%i\n", $2); }
      | lines '\n'
      |
      ;

expr : expr '+' expr { $$ = $1 + $3; }
     | expr '-' expr { $$ = $1 - $3; }
     | expr '*' expr { $$ = $1 * $3; }
     | expr '-' expr { $$ = $1 / $3; }
     | '(' expr ')'  { $$ = $2; }
     | NUMBER
     ;

%%

yylex (){
	int c = getchar ();

	if (c >= '0' && c <= '9'){
		yylval = c - '0';
		return NUMBER;
	}
	return c;
}