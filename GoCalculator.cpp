#include <iostream>
#include <algorithm>
#include "parser.hpp"
#include <string.h>
using namespace std;

extern FILE *yyin;
extern int yy_scan_string(const char *);
int gocalculator(string str);

int main(int argc, char const *argv[]) {
  gocalculator("x+5");
  return 0;
}


int gocalculator(string str) {
  cout << str << endl;
  for(int i=0; i<10; i++){
    string copy = str;
    char y = i + '0';
    cout << y;
    replace(copy.begin(), copy.end(), 'x', y);
    str += '\n';
    yy_scan_string(copy.c_str());
    int a = yyparse();
  }
}
