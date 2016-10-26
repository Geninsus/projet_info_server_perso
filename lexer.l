%{
#include "parser.hpp"
extern int yyparse();
%}

%option noyywrap


texte  [a-zA-z]+
entier [0-9]+(\.[0-9])?

%%

{entier} { yylval.num = atoi(yytext); return(ENTIER);}

"pi" return(PI);
"," return(SEP);
"(" return(LPAR);
")" return(RPAR);
"+" return(PLUS);
"-" return(LESS);
"*" return(TIME);
"/" return(DIVIDE);
"%" return (MODULO);
"sin" return(SIN);
"cos" return(COS);
"tan" return(TAN);
"acos" return(ACOS);
"asin" return(ASIN);
"atan" return(ATAN);
"sqrt" return(ROOT);
"pow" return(POW);
"exp" return(EXP);
"\n" return(END);
{texte} return(ERROR);
%%
