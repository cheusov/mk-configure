
%{
#include <stdio.h>
#include <mkc_libm.h>
%}

%union {
	double value;
	char* name;
}

%token <value> NUMBER

%type  <value>  expr

%left '+' '-'
%right SQRT
%left '*' '/'
%right '^'
%right UMINUS

%%
lines:	lines expr '\n'		{ printf("%.10g\n", $2); }
	|	lines '\n'
	|	error '\n' 		{ printf("Please re-enter last line: ");
	                	  yyerrok; }
	|
	;

expr:	expr '+' expr	{ $$ = $1 + $3; }
	|	expr '-' expr	{ $$ = $1 - $3; }
	|	expr '*' expr	{ $$ = $1 * $3; }
	|	expr '/' expr	{ $$ = $1 / $3; }
	|	expr '^' expr	{ $$ = pow($1, $3); }
	|	'(' expr ')'	{ $$ = $2; }
	|	'-' expr  %prec UMINUS { $$ = -$2; }
	|	NUMBER
	;

%%
#include <ctype.h>
#include <stdio.h>

int main (int argc, char **argv)
{
	return yyparse ();
}

int yyerror (char* errstr)
{
	printf ("Error: %s\n", errstr);
	return 1;
}
