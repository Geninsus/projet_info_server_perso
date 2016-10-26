all: bison flex main.cpp
	g++ parser.cpp lexer.cpp main.cpp -o parser
	rm lexer.cpp parser.cpp parser.hpp
	./parser
bison: parser.y
	bison -o parser.cpp parser.y
flex: lexer.l
	flex -o lexer.cpp lexer.l
