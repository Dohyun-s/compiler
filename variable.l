
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
%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  {
                  yylval.dval = atof(yytext); return NUMBER;
                }

[\t ]+   ;        /* ignore white space */

m[A-Za-z][A-Za-z0-9]*    {      yylval.symp=symlook(yytext); return NAME; }
")("	return ERROR;
"%"	return MOD;
"!"	return FAC;

"$"      { return 0; }    /*  end of input  */
">="	return GE;
"<=" 	return LE;
"=="    return EQ;
"!="    return NE;
"^"   return EXP;
"&"   return LOG;
{addop} { strcpy(yylval.STRING, yytext); return ADDOP;}

([Pp]i)|PI	{ yylval.dval = M_PI; return PI;}
([Ss]in)|SIN	return SIN;
([Cc]os)|COS	return COS;
([Tt]an)|TAN	return TAN;
([Cc]sc)|CSC	return CSC;
([Ss]ec)|SEC	return SEC;
([Cc]ot)|COT	return COT;
([Aa]sin)|ASIN	return ASIN;
([Aa]cos)|ACOS	return ACOS;
([Aa]tan)|ATAN	return ATAN;

[Ee]		{ yylval.dval = M_E; return E; }
([Ll]og)|LOG	return LN;
([Ll]og10)|LOG10	return LOG;


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
