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
%token ROOT POW MODULO EXP

/* CALCUL ORDER */
%left PLUS LESS
%left TIME DIVIDE

/* TRASH */
%token ERROR

%type <num> Line Math Trigo
%start Function
%%
Function :
          /* EMPTY */
        | Function Line
        ;
Line:
         END
      |  Math END {cout << $1 << endl;}
      |  ERROR END {cout << "Please enter a real function" << endl;}
      ;
Math:
        ENTIER {$$ = $1;}
      | LESS ENTIER {$$=-$2;}
      | PI {$$= 3.14159265359;}
      | Math PLUS Math {$$=$1+$3;}
      | Math LESS Math {$$=$1-$3;}
      | Math TIME Math {$$=$1*$3;}
      | Math DIVIDE Math {$$=$1/$3;}
      | ROOT LPAR Math RPAR {$$ = sqrt($3);}
      | POW LPAR Math SEP Math RPAR {$$ = pow($3,$5);}
      | EXP LPAR Math RPAR {$$ = exp($3);}
      /*| Calcul MODULO Calcul {$$=$1%$3;}*/
      | Trigo
      ;
Trigo:
        SIN LPAR Math RPAR {$$ = sin(($3*3.14)/180);}
      | COS LPAR Math RPAR {$$ = cos(($3*3.14)/180);}
      | TAN LPAR Math RPAR {$$ = tan(($3*3.14)/180);}
      | ASIN LPAR Math RPAR {$$ = asin(($3*3.14)/180);}
      | ACOS LPAR Math RPAR {$$ = acos(($3*3.14)/180);}
      | ATAN LPAR Math RPAR {$$ = atan(($3*3.14)/180);}
      ;


%%

extern void yyerror(char const* msg){
  cerr << "Error" << msg << endl;
}
