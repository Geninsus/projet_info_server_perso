  %defines
%{
#include <iostream>
#include <math.h>
using namespace std;
extern int yylex();
int xmin;
int xmax;
extern void yyerror(char const* msg);
%}

%union {double num;char text;}

/* CARACTERES */
%token <num> NUMBER PI
%token <char> OP CP OC CC SEP SECO END

/* TRIGO */
%token COS SIN TAN
%token ACOS ASIN ATAN
/* CALCUL */
%token ADD SUB
%token MUL DIV
%token ROOT POW MODULO EXP ABS NEG

/* CALCUL ORDER */
%left ADD SUB
%left MUL DIV

/* TRASH */
%token ERROR

%type <num> calclist exp factor term
%start line
%%
line:
  | calclist {return $1; }
  | OC term SECO term CC {xmin=$2;xmax=$4;}
  ;
calclist: /* nothing */ {}
 | calclist exp END {$$ = $2;}
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
 | NEG NUMBER {$$= -$2;}
 ;
%%



extern void yyerror(char const* msg){
  cerr << "Error " << msg << endl;
}
