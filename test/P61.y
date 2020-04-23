%{
#include <stdio.h>
#include <string.h>
#include <math.h>
int c[20];
int a=1;
int b=1;
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
%token COPY
%token DELETE
%token SWITCH
%token <ival> INUMBER
%type <ival> expr

%%
end     : line		   {if(b==1 && a==2)
							{printf("%d\n",c[a-1]);}
						else
							{printf("Invalid format");}}
		;
line    : expr line 	
		|							
        ;
expr	: LOAD INUMBER   {c[a]=$2;a++;}
		| ADD			 {if(a>=3)
						  {
							int tmp=c[a-2];
							c[a-2]=tmp+c[a-1];
							c[a-1]=0;
							a--;
						  }
						  else
							{b=0;}
						  }
							
		| SUB			{if(a>=3)
						  {
							int tmp=c[a-2];
							c[a-2]=c[a-1]-tmp;
							c[a-1]=0;
							a--;
						  }
						  else
							{b=0;}}
		| MUL			{if(a>=3)
						  {
							int tmp=c[a-2];
							c[a-2]=tmp*c[a-1];
							c[a-1]=0;
							a--;
						  }
						  else
							{b=0;}}
		| INC			{if(a>=2){c[a-1]++;}else{b=0;}}
						 
		| DEC			{if(a>=2){c[a-1]--;}else{b=0;}}
		| MOD			{if(a>=3)
						  {
							int tmp=c[a-2];
							c[a-2]=c[a-1]%tmp;
							c[a-1]=0;
							a--;
						  }
						  else
							{b=0;}}
		| COPY			{if(a>=2)
							{
							c[a]=c[a-1];
							a++;
							}
							else{b=0;}

						}
		| DELETE		{if(a>=2)
							{
							c[a-1]=0;
							a--;
							}
							else{b=0;}

						}
		| SWITCH		{if(a>=3)
							{
							int temp = c[a-2];
							c[a-2] = c[a-1];
							c[a-1] = temp;
							}
							else{b=0;}

						}
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
