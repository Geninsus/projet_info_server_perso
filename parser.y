  %defines
%{
#include <iostream>
#include <math.h>
using namespace std;
extern int yylex();
extern void yyerror(char const* msg);
%}

%union {double num;}

/* CARACTERES */
%token <num> NUMBER PI
%token OP CP SEP END

/* TRIGO */
%token COS SIN TAN
%token ACOS ASIN ATAN
/* CALCUL */
%token ADD SUB
%token MUL DIV
%token ROOT POW MODULO EXP ABS

/* CALCUL ORDER */
%left ADD SUB
%left MUL DIV

/* TRASH */
%token ERROR

%type <num> calclist exp factor term
%start calclist
%%
calclist: /* nothing */
 | calclist exp END {cout << $2 << endl;}
 ;
exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;
factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;
term: NUMBER
 | OP exp CP {$$ = $2;}
 ;
%%



extern void yyerror(char const* msg){
  cerr << "Error " << msg << endl;
}
