%{
#include <stdio.h>
#include "parser.tab.h" // Arquivo de cabeçalho gerado pelo Bison
%}

letra   [a-zA-Z]
digito  [0-9]

%%

"int"               { return INT; }
"char"              { return CHAR; }
"float"             { return FLOAT; }
"string"            { return STRING; }
"console"           { return CONSOLE; }
"in"                { return IN; }
"if"                { return IF; }
"else"              { return ELSE; }
"while"             { return WHILE; }
"for"               { return FOR; }

{letra}({letra}|{digito})* { yylval.sval = strdup(yytext); return VARIAVEL; }

-?{digito}+         { yylval.ival = atoi(yytext); return INTEIRO; }
-?{digito}+\.{digito}+ { yylval.fval = atof(yytext); return FLOAT_LITERAL; }
\'{letra}\'         { yylval.sval = strdup(yytext); return CHAR_LITERAL; }
\"{letra}+\"       { yylval.sval = strdup(yytext); return STRING_LITERAL; }

"="                 { return ATRIBUICAO; }
"\+="               { return MAIS_IGUAL; }
"-="               { return MENOS_IGUAL; }
"\*="               { return VEZES_IGUAL; }
"/="               { return DIVIDE_IGUAL; }

"=="                { return IGUAL_IGUAL; }
">="                { return MAIOR_IGUAL; }
"<="                { return MENOR_IGUAL; }
">"                 { return MAIOR; }
"<"                 { return MENOR; }
"!="                { return DIFERENTE; }

"&&"                { return E_LOGICO; }
"||"                { return OU_LOGICO; }
"!"                 { return NAO_LOGICO; }

"+"                 { return SOMA; }
"-"                 { return SUB; }
"*"                 { return MULT; }
"/"                 { return DIV; }
"**"                { return POT; }
"%"                 { return MOD; }

":"                 { return DOIS_PONTOS; }
";"                 { return PONTO_E_VIRGULA; }
"("                 { return PARENTESES_ESQ; }
")"                 { return PARENTESES_DIR; }
"{"                 { return INICIO_BLOCO; }
"}"                 { return FIM_BLOCO; }

[ \t\n]+            ; /* Ignora espaços em branco */
.                   { yyerror("Caractere invalido"); }

%%

int yywrap() {
    return 1;
}