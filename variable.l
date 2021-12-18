
%{
#include "symbol.h"
#include "y.tab.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>
extern double vbltable[26];
extern struct symtab *symlook(char *);
//extern double factorial(double);
%}
%option nounput
%option noinput
%option noyywrap
addop [+-]
mulop [*/%]
%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  {
                  yylval.dval = atof(yytext); return NUMBER;
                }
[\t ]+   ;        /* ignore white space */
m[A-Za-z][A-Za-z0-9]*    {      yylval.symp=symlook(yytext); return NAME; }
")("	return ERROR;
"!"	return FAC;
"$"      { return 0; }    /*  end of input  */
"=="|">="|"<="|">"|"<"|"!=" { strcpy(yylval.STRING,yytext); return RELOP;}
"^"   return EXP;
{addop} { strcpy(yylval.STRING, yytext); return ADDOP;}
{mulop} { strcpy(yylval.STRING, yytext); return MULOP;}

([Pp]i)|PI	{ yylval.dval = M_PI; return PI;}
([Ss]in)|SIN|([Cc]os)|COS|([Tt]an)|TAN|([Cc]sc)|CSC|([Ss]ec)|SEC|([Cc]ot)|COT|([Aa]sin)|ASIN|([Aa]cos)|ACOS|([Aa]tan)|ATAN
{ strcpy(yylval.STRING, yytext); return TRIGO;}	

[Ee]		{ yylval.dval = M_E; return E; }
([Ll]og)|LOG|([Ll]og10)|LOG10	{strcpy(yylval.STRING, yytext); return LOG;}
"("   return LEFT;
")"   return RIGHT;
[ \n]       |
.                return yytext[0];
%%
/*
int yywrap(void) {
	return 1;
}
*/
