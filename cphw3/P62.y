%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int a = 0;
int b =0;
int c = 0;
void yyerror(const char *message);
void semantic(const int);
%}
%union {
struct s {
	int x;
	int y;
	
} t;
int ival;
}
%token <ival> INUMBER
%type <t> matrix
%type <t> expr
%left <ival> '+' '-'
%left <ival> '*'
%left '(' ')'
%left transpose
%%
line    : expr                          { 
							if(a <=0 || b<= 0){
								printf("Syntax Error");
								c++;
								}else{
									c++;
									printf("%d %d \n",a,b);
									} }
         ;
expr    : expr '+' expr                 { if($1.x!=$3.x || $1.y!=$3.y){ semantic($2);return(0); }else{ $$.x=$1.x;$$.y=$1.y; a = $1.x;b=$1.y;} }
        | expr '-' expr                 { if($1.x!=$3.x || $1.y!=$3.y){ semantic($2);return(0); }else{ $$.x=$1.x;$$.y=$1.y;a = $1.x;b=$1.y; } }
        | expr '*' expr                 { if($1.y!=$3.x){ semantic($2);return(0); }else{ $$.x=$1.x;$$.y=$3.y;a = $1.x;b=$3.y; } }
        | expr transpose                { $$.x=$1.y;$$.y=$1.x; a = $1.y;b=$1.x;}
        | '(' expr ')'                  { $$.x=$2.x;$$.y=$2.y;a = $2.x;b=$2.y; }
        | matrix
        ;
matrix  : '[' INUMBER ',' INUMBER ']'	{ $$.x=$2;$$.y=$4;a = $2;b=$4;  }
        ;

%%
void yyerror (const char *message)
{
        fprintf (stderr, "Syntax Error\n");
}

void semantic(int location){
	printf("Semantic error on col %d\n", location);
	c++;
}

int main(int argc, char *argv[]) {
        yyparse();
	if(c ==0){
	printf("Syntax Error");
	}
        return(0);
}
