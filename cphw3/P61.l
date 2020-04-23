%option noyywrap
%{
#include "P61.tab.h"
%}

%%
\n        {}
[ \t]+	  { /* DONT NEEED TO DO*/ }
"add"     {return ADD;}
"sub"	  {return SUB;}
"mul"     {return MUL;}
"mod"     {return MOD;}
"inc"	  {return INC;}
"dec"	  {return DEC;}
"load"    {return LOAD;}
"copy"  {return COPY;}
"delete" {return DELETE;}
"switch" {return SWITCH;}
[0-9]+	  { yylval.ival= atoi(yytext);return(INUMBER); }
.	      { return(yytext[0]); }
%%
