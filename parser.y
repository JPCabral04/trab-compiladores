%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%union {
    int ival;
    float fval;
    char *sval;
}

%token <sval> VARIAVEL
%token <ival> INTEIRO
%token <fval> FLOAT_LITERAL
%token <sval> CHAR_LITERAL
%token <sval> STRING_LITERAL

%token INT CHAR FLOAT STRING CONSOLE IN IF ELSE WHILE FOR
%token ATRIBUICAO MAIS_IGUAL MENOS_IGUAL VEZES_IGUAL DIVIDE_IGUAL
%token IGUAL_IGUAL MAIOR_IGUAL MENOR_IGUAL MAIOR MENOR DIFERENTE
%token E_LOGICO OU_LOGICO NAO_LOGICO
%token SOMA SUB MULT DIV POT MOD
%token DOIS_PONTOS PONTO_E_VIRGULA PARENTESES_ESQ PARENTESES_DIR INICIO_BLOCO FIM_BLOCO

/* ================================================================== */
/* Regras de precedência e associatividade                            */
/* ================================================================== */
/* A precedência aumenta de cima para baixo. Operadores na mesma      */
/* linha têm a mesma precedência.                                     */
/* %left significa associatividade à esquerda (ex: 5-3-2 é (5-3)-2)    */
/* %right significa associatividade à direita (ex: 2**3**2 é 2**(3**2)) */
/* %nonassoc é para operadores que não se associam (ex: <, >)         */

%nonassoc IGUAL_IGUAL MAIOR_IGUAL MENOR_IGUAL MAIOR MENOR DIFERENTE
%left E_LOGICO OU_LOGICO
%left SOMA SUB
%left MULT DIV MOD
%right POT      /* Potência é geralmente associativa à direita */
%nonassoc NAO_LOGICO
%token UMENOS   /* Token "fantasma" para o menos unário */

/* Regra para resolver a ambiguidade do 'dangling else' */
%nonassoc ELSE

%start PROGRAM

%%

PROGRAM:
    INICIO_BLOCO STATEMENT_LIST FIM_BLOCO
    ;

STATEMENT_LIST:
    STATEMENT
    | STATEMENT_LIST STATEMENT
    ;

STATEMENT:
    DECLVAR
    | ASSIGN
    | INPUT_CMD
    | OUTPUT_CMD
    | COND
    | REPET
    | EXP_STATEMENT
    ;

DECLVAR:
    VARIAVEL DOIS_PONTOS TIPO PONTO_E_VIRGULA
    ;

TIPO:
    INT | CHAR | FLOAT | STRING
    ;

ASSIGN:
    VARIAVEL ATRIBUICAO DADO PONTO_E_VIRGULA
    ;

INPUT_CMD:
    VARIAVEL ATRIBUICAO IN PARENTESES_ESQ TIPO PARENTESES_DIR PONTO_E_VIRGULA
    ;

OUTPUT_CMD:
    CONSOLE PARENTESES_ESQ DADO PARENTESES_DIR PONTO_E_VIRGULA
    ;

COND:
    IF PARENTESES_ESQ CONDITION PARENTESES_DIR INICIO_BLOCO STATEMENT_LIST FIM_BLOCO
    | IF PARENTESES_ESQ CONDITION PARENTESES_DIR INICIO_BLOCO STATEMENT_LIST FIM_BLOCO ELSE INICIO_BLOCO STATEMENT_LIST FIM_BLOCO
    ;

CONDITION:
    EXP relacional EXP
    | EXP logico EXP
    ;

relacional:
    IGUAL_IGUAL | MAIOR_IGUAL | MENOR_IGUAL | MAIOR | MENOR | DIFERENTE
    ;

logico:
    E_LOGICO | OU_LOGICO
    ;

REPET:
    WHILE PARENTESES_ESQ CONDITION PARENTESES_DIR INICIO_BLOCO STATEMENT_LIST FIM_BLOCO
    | FOR PARENTESES_ESQ ASSIGN CONDITION PONTO_E_VIRGULA EXP PARENTESES_DIR INICIO_BLOCO STATEMENT_LIST FIM_BLOCO
    ;

EXP_STATEMENT:
    EXP PONTO_E_VIRGULA
    ;

EXP:
    INTEIRO
    | FLOAT_LITERAL
    | CHAR_LITERAL
    | STRING_LITERAL
    | VARIAVEL
    | EXP SOMA EXP
    | EXP SUB EXP
    | EXP MULT EXP
    | EXP DIV EXP
    | EXP POT EXP
    | EXP MOD EXP
    | PARENTESES_ESQ EXP PARENTESES_DIR
    | SUB EXP %prec UMENOS   /* Regra para o menos unário, ex: x = -5 */
    | NAO_LOGICO EXP
    ;

DADO:
    EXP
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    }
    yyparse();
    return 0;
}
