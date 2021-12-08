//symbol.h
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#define NSYMS 100/* maximum number of symbols */
#include <stdbool.h>
struct symtab {
  char *name;
  double value;
  int state;
} symtab[NSYMS];
//struct symtab *symlook();
/*struct symtab *symlook(char *s)
{
	struct symtab *sp;
	for(sp=symtab; sp < &symtab[NSYMS]; sp++) {
	if(sp->name && !strcmp(sp->name, s))
			return sp;
		if(!sp->name) {
			sp->name=strdup(s);
			return sp;
		}
	}
	fprintf(stderr, "%s\n", "Too many symbols");
	//yyerror2("Too many symbols");
	exit(1);
}*/
