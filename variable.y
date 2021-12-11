%{
#include <stdio.h>
void yyerror(const char* msg) {
	fprintf(stderr, "%s\n", msg);
}
#include "symbol.h"
#include <math.h>
#include <string.h>
double factorial(double);
float calculate(float num1, float num2, char operation[5]);
int yylex();
void yyerror(const char *s);
//double vbltable[26];  /* double형의 기억장소 배열 */
%}
%union  {
                double dval;
                struct symtab *symp;
		char STRING[100];
        }
%left PI SIN COS TAN CSC SEC COT ASIN ACOS ATAN
%left E LOG LN EXP FAC MOD
%left ERROR

%token    <symp> NAME
%token    <dval> NUMBER
%token ADDOP RELOP 
%type <STRING> ADDOP RELOP 


%left   LEFT
%right  RIGHT
//%left     '>' '<'
//%left GE LE EQ NE
%left RELOP
%left ADDOP  
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS UPLUS
%type <dval> expression
%%

statement_list: statement '\n'
	                |         statement_list statement '\n'	
	;
statement:        NAME '=' expression  { $1->value = $3; $1->state=1; }
	           |   expression                 { printf("= %g\n",$1); }
;
//addop: '-' | '+';
//mulop: '*' | '/';
expression: expression ADDOP expression {$$ = calculate($1, $3,$2); }  	
	  | expression ADDOP {yyerrok; yyerror("right operator doesn't exist"); $$=$1;}
	  | expression '*' expression  { $$ = $1 * $3;  }
         // | expression '-'  expression  { $$ = $1 - $3;  }
          | expression '/' expression
                    {  if($3 == 0.0){
                             yyerror("divide by zero");
			     return -1;
			}


                       else   $$ = $1 /$3;
                    }
	   //|expression op expression { $$ = opr($1, $2, $3);}
           |  '-'expression  %prec UMINUS   { $$ = -$2; }
	   |  '+'expression  %prec UPLUS  {$$=$2;}
	  
	   |  LEFT expression RIGHT { $$=$2;}
	   |  LEFT RIGHT { yyerrok; yyerror("Blank In the parenthesis error");}
	   |  LEFT expression   { yyerrok; yyerror("Right parenthesis missing error"); $$=$2; }
//	   |  expression LEFT   { yyerrok; yyerror("parenthesis matching error"); $$=$1; }
	   |  expression RIGHT { yyerrok; yyerror("Left parenthesis missing error"); $$=$1;}
//	   |  RIGHT expression {yyerrok; yyerror("parenthesis matching error"); $$=$2;}

           |       NUMBER
           |       NAME       { 
				if ($1->state==-1)
				//	printf("%s", $1->name);
					yyerror("there is free variable");
				
				$$ = $1->value; }
	   |	   E
	   |	   PI
	   | expression RELOP expression {$$=calculate($1,$3,$2);}
	   
	   | expression RELOP {yyerrok; yyerror("right relation operator doesn't exist"); $$=$1;}
	   | RELOP expression {yyerrok; yyerror("left relation operator doesn't exist"); $$=$2;}
	   | expression FAC { $$ = factorial($1); }
	   | SIN expression { $$ = sin($2); }
	   | COS expression { $$ = cos($2); }
	   | TAN expression { $$ = tan($2); }
	   | CSC expression {  if (cos($2) == 0.0) {
					yyerror("cos is zero");
					}
			       else
					$$ = (1/cos($2)); }
	   | SEC expression {  if (sin($2) == 0.0) {
					yyerror("sin argument is zero");
				 }
			       else
					$$ = (1/sin($2)); }
	   | COT expression {  if (tan($2) == 0.0) {
					yyerror("tan argument is zero");
					}
			       else
					$$ = (1/tan($2)); }
	   | ASIN expression { if ($2>1 || $2<-1) {
					yyerror("asin range error");
					}
				else 
					$$ = asin($2); }
	   | ACOS expression { if ($2>1 || $2<-1) {
					yyerror("scos range error");
					}
				else
					$$ = acos($2); }
	   | ATAN expression { return $$ = atan($2);}
	   | expression MOD expression { $$ = fmod($1, $3); } 
	   | expression EXP expression { $$ = pow($1, $3);}		     
	   | LOG expression {  if ($2==0.0) {
					yyerror("argument zero");
					}
			       else
			 	$$ = log10($2);}
	   | LN expression { if ($2==0.0) {
					yyerror("argument zero");
					}
				else
				$$ = log($2); }	
	   | expression ERROR expression { yyerror("parenthesis error"); return -1; }
	   | expression ERROR { yyerror("parenthesis error"); return -1; }
	   | ERROR expression { yyerror("parenthesis error"); return -1; }
	   | LEFT { yyerror("parenthesis error"); }
	   | RIGHT { yyerror("parenthesis error"); }
;
%%
int main()
{
    yyparse();
}

struct symtab *symlook(char *s)
{
	struct symtab *sp;
	for(sp=symtab; sp < &symtab[NSYMS]; sp++) {
		/* is it already here ? */
		if(sp->name && !strcmp(sp->name, s))
			return sp;
		/* is it free ? */
		if(!sp->name) {
			sp->state=-1;
			sp->name=strdup(s);
			return sp;
		}
		/* otherwise continue to next */
	}
	
	fprintf(stderr, "%s","Too many symbols");
	exit(1);
}

double factorial(double tmp){
	double re = 1;
	while(tmp > 1) {
		re = re * tmp;
		tmp--;
	}
	return re;
}
float calculate(float x, float y, char operation[5]){
	if(strcmp(operation,"*")==0) return x*y;
	if(strcmp(operation,"/")==0) return x-y;
	if(strcmp(operation,"+")==0) return x+y;
	if(strcmp(operation,"-")==0) return x-y;
	if(strcmp(operation,"==")==0) return  x ==y;		
	if(strcmp(operation,"!=")==0) return x != y;		
	if(strcmp(operation,">=")==0) return x >= y;		
	if(strcmp(operation,"<=")==0) return x <= y;		
	if(strcmp(operation,">")==0)  return x > y;		
	if(strcmp(operation,"<")==0)  return x < y;
	return 0;
}

