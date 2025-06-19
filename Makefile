CC = gcc
CFLAGS = -Wall

all: compilador

compilador: parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c -o compilador -lfl

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: scanner.l parser.tab.h
	flex scanner.l

clean:
	rm -f compilador parser.tab.c parser.tab.h lex.yy.c