%{
#include <ctype.h>
#include <stdio.h>

#define YYSTYPE int
void yyerror (char const *s);
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

void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int main (int argc, char **argv)
{
	yyparse ();
	return 0;
}
