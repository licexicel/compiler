%{
#include <stdio.h>
#include <string.h>
#include <math.h>
int c[20];
int k=1;
int w=1;
void yyerror(const char *message);

%}
%union {
int ival;
}
%token ADD
%token SUB
%token MUL
%token MOD
%token LOAD
%token INC
%token DEC
%token <ival> INUMBER
%type <ival> expr

%%
end     : line		   {if(w==1 && k==2)
							{printf("%d\n",c[k-1]);}
						else
							{printf("Invalid format");}}
		;
line    : expr line 	
		|							
        ;
expr	: LOAD INUMBER   {c[k]=$2;k++;}
		| ADD			 {if(k>=3)
						  {
							int tmp=c[k-2];
							c[k-2]=tmp+c[k-1];
							c[k-1]=0;
							k--;
						  }
						  else
							{w=0;}
						  }
							
		| SUB			{if(k>=3)
						  {
							int tmp=c[k-2];
							c[k-2]=c[k-1]-tmp;
							c[k-1]=0;
							k--;
						  }
						  else
							{w=0;}}
		| MUL			{if(k>=3)
						  {
							int tmp=c[k-2];
							c[k-2]=tmp*c[k-1];
							c[k-1]=0;
							k--;
						  }
						  else
							{w=0;}}
		| INC			{if(k>=2){c[k-1]++;}else{w=0;}}
						 
		| DEC			{if(k>=2){c[k-1]--;}else{w=0;}}
		| MOD			{if(k>=3)
						  {
							int tmp=c[k-2];
							c[k-2]=c[k-1]%tmp;
							c[k-1]=0;
							k--;
						  }
						  else
							{w=0;}}
		;
		
%%
void yyerror (const char *message)
{
        fprintf (stderr, "%s\n",message);
}

int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}
