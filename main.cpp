#include <iostream>
#include "parser.hpp"
#include <string.h>
using namespace std;

extern FILE *yyin;
extern FILE *yyout;
extern int yy_scan_string(const char *);


int main(int argc, char const *argv[]) {
  string str = argv[1];
  str += '\n';
  yy_scan_string(str.c_str());
  yyparse();
}
