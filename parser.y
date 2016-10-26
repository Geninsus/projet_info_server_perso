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
%token <num> ENTIER PI
%token LPAR RPAR SEP END

/* TRIGO */
%token COS SIN TAN
%token ACOS ASIN ATAN

/* CALCUL */
%token PLUS LESS
%token TIME DIVIDE
%token ROOT POW MODULO

/* CALCUL ORDER */
%left PLUS LESS
%left TIME DIVIDE

/* TRASH */
%token ERROR

%type <num> Line Calcul
%start Function
%%
Function :
          /* EMPTY */
        | Function Line
        ;
Line:
         END
      |  Calcul END {cout << $1 << endl;}
      |  ERROR END {cout << "Wrong sequence" << endl;}
      ;
Calcul: ENTIER {$$ = $1;}
      | LESS ENTIER {$$=-$2;}
      | PI {$$= 3.14159265359;}
      | Calcul PLUS Calcul {$$=$1+$3;}
      | Calcul LESS Calcul {$$=$1-$3;}
      | Calcul TIME Calcul {$$=$1*$3;}
      | Calcul DIVIDE Calcul {$$=$1/$3;}
      | ROOT LPAR Calcul RPAR {$$ = sqrt($3);}
      | POW LPAR Calcul SEP Calcul RPAR {$$ = pow($3,$5);}
      | SIN LPAR Calcul RPAR {$$ = sin(($3*3.14)/180);}
      | COS LPAR Calcul RPAR {$$ = cos(($3*3.14)/180);}
      | TAN LPAR Calcul RPAR {$$ = tan(($3*3.14)/180);}
      | ASIN LPAR Calcul RPAR {$$ = asin(($3*3.14)/180);}
      | ACOS LPAR Calcul RPAR {$$ = acos(($3*3.14)/180);}
      | ATAN LPAR Calcul RPAR {$$ = atan(($3*3.14)/180);}
      /*| Calcul MODULO Calcul {$$=$1%$3;}*/
      ;
/*Trigo:
    SIN LPAR Calcul RPAR {$$ = sin(($3*3.14)/180);}
    | COS LPAR Calcul RPAR {$$ = cos(($3*3.14)/180);}
    | TAN LPAR Calcul RPAR {$$ = tan(($3*3.14)/180);}
    | ASIN LPAR Calcul RPAR {$$ = asin(($3*3.14)/180);}
    | ACOS LPAR Calcul RPAR {$$ = acos(($3*3.14)/180);}
    | ATAN LPAR Calcul RPAR {$$ = atan(($3*3.14)/180);}
    ;*/


%%

extern void yyerror(char const* msg){
  cerr << "Error" << msg << endl;
}
