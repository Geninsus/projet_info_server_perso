#include <iostream>
#include <algorithm>
#include <map>
#include "parser.hpp"
#include <string.h>
using namespace std;

extern int xmin;
extern int xmax;
extern FILE *yyin;
extern int yy_scan_string(const char *);
map<double,double> gocalculator(string str);
void scan_string(string str);
bool replace(std::string& str, const std::string& from, const std::string& to);


int main(int argc, char const *argv[]) {
  gocalculator("[0;3](5*x +2)");
  return 0;
}


map<double,double> gocalculator(string str) {
  cout << str << endl;
  map<double,double> values;
  string function="";
  /* Recherche de l'emplacement des conditions */
  size_t oc = str.find("[");
  size_t cc = str.find("]");

  /* Separe la fonction et les conditions */
  if(oc!=string::npos && cc!=string::npos){
    /* Conditions */
    string cond = str.substr(oc,cc+1);
    cond += '\n';
    /* Fonction */
    function = str.substr(cc+1,str.size());
    /* Suppression des espaces inutiles */
    function.erase(remove_if(function.begin(), function.end(), ::isspace),function.end());
    /* Scan des conditions */
    yy_scan_string(cond.c_str());
    yyparse();
  }
  if(function!=""){
    str = function;
  }
  /* Calcul les valeurs pour chaque x de l'expression str*/
  /* Calcul all values for each x of the expression str*/
  for(int x=xmin; x<=xmax; x++){
    string  xbis = std::to_string(x);
    string copy = str;
    /* On remplace x dans la fonction par sa valeur */
    replace(copy,"x",xbis);
    str += '\n';
    yy_scan_string(copy.c_str());
    /* On scan et stock dans une map avec les coordonées */
    values[x] = yyparse();
  }
  for(int i =xmin;i<=xmax;i++){
    cout << i << " : " << values[i] << endl;
  }
  return values;
}
/* Fonction de remplacement de sring dans un string */
bool replace(std::string& str, const std::string& from, const std::string& to) {
    size_t start_pos = str.find(from);
    if(start_pos == std::string::npos)
        return false;
    str.replace(start_pos, from.length(), to);
    return true;
}
