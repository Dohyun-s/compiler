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
float calculate2(float num1, char op[5]);
int yylex();
void yyerror(const char *s);
//double vbltable[26];  /* double형의 기억장소 배열 */
%}
%union  {
                double dval;
                struct symtab *symp;
		char STRING[100];
        }
%left ERROR

%token    <symp> NAME
%token    <dval> NUMBER
%token ADDOP RELOP MULOP TRIGO
%type <STRING> ADDOP RELOP MULOP TRIGO


%left   LEFT
%right  RIGHT
//%left     '>' '<'
//%left GE LE EQ NE
%left RELOP
%left LOG LN EXP FAC MOD
//%left '-' '+'
%left ADDOP
%left MULOP  
//%left '*' '/'
%left TRIGO
%left E PI
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
	  | expression MULOP expression {$$ =calculate($1, $3,$2);} 
	  | expression MULOP {yyerrok; yyerror("right operator doesn't exist"); $$=$1;}
	  | MULOP expression {yyerrok; yyerror("left operator doesn't exist"); $$=$2;}
	// | expression '*' expression  { $$ = $1 * $3;  }
         // | expression '-'  expression  { $$ = $1 - $3;  }
         /* | expression '/' expression
                    {  if($3 == 0.0){
                             yyerror("divide by zero");
			     
			}


                       else   $$ = $1 /$3;
                    }
        */  
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
	   | RELOP {yyerrok; yyerror("only operator, give values");} 
	   | ADDOP {yyerrok; yyerror("only operator, give values");} 
	   | MULOP {yyerrok; yyerror("only operator, give values");} 
	   | expression RELOP {yyerrok; yyerror("right relation operator doesn't exist"); $$=$1;}
	   | RELOP expression {yyerrok; yyerror("left relation operator doesn't exist"); $$=$2;}
	   | expression FAC { $$ = factorial($1); }
	   
	   | TRIGO expression {$$=calculate2($2, $1);}
	   | TRIGO {yyerrok; yyerror("only operator, give argument");}
	   | expression TRIGO {yyerrok; yyerror("only operator, give argument");}
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
	   | LEFT { yyerror("parenthesis alone"); }
	   | RIGHT { yyerror("parenthesis alone"); }
	   | ADDOP { yyerror("addop alone"); }
	   | MULOP { yyerror("mulop alone"); }
	   | RELOP { yyerror("relop alone");}
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
	if(strcmp(operation,"/")==0) {if (y==0) yyerror("divide by zero");return x/y;}
	if(strcmp(operation,"+")==0) {return x+y;}
	if(strcmp(operation,"-")==0) return x-y;
	if(strcmp(operation,"==")==0) return  x ==y;		
	if(strcmp(operation,"!=")==0) return x != y;		
	if(strcmp(operation,">=")==0) return x >= y;		
	if(strcmp(operation,"<=")==0) return x <= y;		
	if(strcmp(operation,">")==0)  return x > y;		
	if(strcmp(operation,"<")==0)  return x < y;
	if(strcmp(operation,"%")==0) return fmod(x,y);
	if(strcmp(operation,"^")==0) return pow(x,y);
	return 0;
}

float calculate2(float x, char op[5]){
	if(strcmp(op,"sin")==0 ||strcmp(op,"Sin")==0 ||strcmp(op,"SIN")==0  ) {
		return sin(x);}
	if(strcmp(op,"cos")==0 ||strcmp(op,"Cos")==0 || strcmp(op,"COS")==0  ) return cos(x);
	if(strcmp(op,"tan")==0||strcmp(op,"TAN")==0||strcmp(op,"Tan")==0  ) return tan(x);
	if(strcmp(op,"csc")==0 ||strcmp(op,"Csc")==0 ||strcmp(op,"CSC")==0) {
		 if (sin(x)==0) 
			 yyerror("sin argument is zero"); 
			
		 else return 1/sin(x);
	}
	if(strcmp(op,"sec")==0  ||strcmp(op,"SEC")==0 ||strcmp(op,"Sec")==0  ) {
		 if (cos(x)==0){  yyerror("cos argument is zero");} else return 1/cos(x);}
	if(strcmp(op,"cot")==0||strcmp(op,"Cot")==0||strcmp(op,"COT")==0  ) {
		 if (tan(x)==0)  yyerror("tan argument is zero"); else return 1/tan(x);}
	if(strcmp(op,"asin")==0||strcmp(op,"ASIN")==0||strcmp(op,"Asin")==0 ){
		 if (x>1 || x<-1 )  yyerror("asin range error"); else return asin(x);}
	if(strcmp(op,"acos")==0 ||strcmp(op,"Acos")==0 ||strcmp(op,"ACOS")==0 ) {
		 if (x>1 || x<-1 )  yyerror("asin range error"); else return acos(x);}
	if(strcmp(op,"atan")==0 ||strcmp(op,"atan")==0 ||strcmp(op,"atan")==0) return atan(x);
	
	if(strcmp(operation,"Log")==0||strcmp(operation,"log")==0||strcmp(operation,"LOG")==)			{if (x==0.0) {yyerror("argument zero");} else return log(x)} 
	if(strcmp(operation,"Log10")==0||strcmp(operation,"log10")==0||strcmp(operation,"LOG10")==)			{if (x==0.0) {yyerror("argument zero");} else return log10(x)} 
	return 0;
}


