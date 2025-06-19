%{
#include <stdio.h>
#include "parser.tab.h" // Arquivo de cabeçalho gerado pelo Bison

/* Declaração da função de erro do parser para que o scanner a conheça */
void yyerror(const char*);
%}

letra   [a-zA-Z]
digito  [0-9]

%%

"int"               { printf("palavra reservada -> %s\n", yytext); return INT; }
"char"              { printf("palavra reservada -> %s\n", yytext); return CHAR; }
"float"             { printf("palavra reservada -> %s\n", yytext); return FLOAT; }
"string"            { printf("palavra reservada -> %s\n", yytext); return STRING; }
"console"           { printf("palavra reservada -> %s\n", yytext); return CONSOLE; }
"in"                { printf("palavra reservada -> %s\n", yytext); return IN; }
"if"                { printf("comando condicional -> %s\n", yytext); return IF; }
"else"              { printf("comando condicional -> %s\n", yytext); return ELSE; }
"while"             { printf("comando de repeticao -> %s\n", yytext); return WHILE; }
"for"               { printf("comando de repeticao -> %s\n", yytext); return FOR; }

{letra}({letra}|{digito})* { printf("identificador -> %s\n", yytext); yylval.sval = strdup(yytext); return VARIAVEL; }

-?{digito}+         { printf("numero inteiro -> %s\n", yytext); yylval.ival = atoi(yytext); return INTEIRO; }
-?{digito}+\.{digito}+ { printf("numero real -> %s\n", yytext); yylval.fval = atof(yytext); return FLOAT_LITERAL; }
\'[^\']\'         { printf("caractere -> %s\n", yytext); yylval.sval = strdup(yytext); return CHAR_LITERAL; }
\"[^"]*\"         { printf("string -> %s\n", yytext); yylval.sval = strdup(yytext); return STRING_LITERAL; }

"="                 { printf("atribuicao -> %s\n", yytext); return ATRIBUICAO; }
"\+="               { printf("atribuicao -> %s\n", yytext); return MAIS_IGUAL; }
"-="               { printf("atribuicao -> %s\n", yytext); return MENOS_IGUAL; }
"\*="               { printf("atribuicao -> %s\n", yytext); return VEZES_IGUAL; }
"/="               { printf("atribuicao -> %s\n", yytext); return DIVIDE_IGUAL; }

"=="                { printf("operador relacional -> %s\n", yytext); return IGUAL_IGUAL; }
">="                { printf("operador relacional -> %s\n", yytext); return MAIOR_IGUAL; }
"<="                { printf("operador relacional -> %s\n", yytext); return MENOR_IGUAL; }
">"                 { printf("operador relacional -> %s\n", yytext); return MAIOR; }
"<"                 { printf("operador relacional -> %s\n", yytext); return MENOR; }
"!="                { printf("operador relacional -> %s\n", yytext); return DIFERENTE; }

"&&"                { printf("operador logico -> %s\n", yytext); return E_LOGICO; }
"||"                { printf("operador logico -> %s\n", yytext); return OU_LOGICO; }
"!"                 { printf("operador logico -> %s\n", yytext); return NAO_LOGICO; }

"+"                 { printf("operador aritmetico -> %s\n", yytext); return SOMA; }
"-"                 { printf("operador aritmetico -> %s\n", yytext); return SUB; }
"*"                 { printf("operador aritmetico -> %s\n", yytext); return MULT; }
"/"                 { printf("operador aritmetico -> %s\n", yytext); return DIV; }
"**"                { printf("operador aritmetico -> %s\n", yytext); return POT; }
"%"                 { printf("operador aritmetico -> %s\n", yytext); return MOD; }

":"                 { printf("delimitador -> %s\n", yytext); return DOIS_PONTOS; }
";"                 { printf("delimitador -> %s\n", yytext); return PONTO_E_VIRGULA; }
"("                 { printf("abre parenteses -> %s\n", yytext); return PARENTESES_ESQ; }
")"                 { printf("fecha parenteses -> %s\n", yytext); return PARENTESES_DIR; }
"{"                 { printf("abre chaves -> %s\n", yytext); return INICIO_BLOCO; }
"}"                 { printf("fecha chaves -> %s\n", yytext); return FIM_BLOCO; }

[ \t\n]+            ; /* Ignora espaços em branco */
.                   { yyerror("Caractere invalido"); }

%%

int yywrap() {
    return 1;
}
