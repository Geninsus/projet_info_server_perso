%{
#include "parser.hpp"
extern int yyparse();
%}

%option noyywrap


texte  [a-zA-z]+
entier [0-9]+(\.[0-9])?

%%

{entier} { yylval.num = atoi(yytext); return(NUMBER);}
"-" return(NEG);
"pi" return(PI);
"[" return(OC);
"]" return(CC);
"," return(SEP);
";" return(SECO);
"(" return(OP);
")" return(CP);
"+" return(ADD);
"-" return(SUB);
"*" return(MUL);
"/" return(DIV);
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
