CC = gcc
CFLAGS = -Wall

LIB_PATH = -L/usr/lib

FLEX_LIB = -lfl

all: compilador

compilador: parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c -o compilador $(LIB_PATH) $(FLEX_LIB)

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: scanner.l parser.tab.h
	flex scanner.l

clean:
	rm -f compilador parser.tab.c parser.tab.h lex.yy.c