%{
#include "P62.tab.h"
int loca=0;
%}
%%
\n                                      { return yytext[0]; }
[0-9]+                                  { loca = loca+yyleng;yylval.ival = atoi(yytext);return(INUMBER); }
"+"|"-"|"*"|"("|")"|"["|"]"|","		{ loca=loca+yyleng;yylval.ival=loca;return(yytext[0]); }
"^T"                                    { loca = loca+yyleng;return(transpose); }
[ \t]+                                  { loca=loca+yyleng; }
.                                       { return(yytext[0]); }
%%

