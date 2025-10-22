%option noyywrap
%option yylineno
%option nodefault
%option reentrant
%option bison-bridge

%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

static char* sdup(const char* s){
  if(!s) return NULL;
  size_t n=strlen(s)+1;
  char* p=(char*)malloc(n);
  if(p) memcpy(p,s,n);
  return p;
}
%}

%x COMMENT

%%

[ \t\r]+                  { }
\n                        { }

[/][/][^\n]*              { }
[/][*]                    { BEGIN(COMMENT); }
<COMMENT>[*][/]           { BEGIN(INITIAL); }
<COMMENT>\n               { }
<COMMENT>.                { }

"inteiro"                 { return T_INTEIRO; }
"se"                      { return T_SE; }
"entao"                   { return T_ENTAO; }
"senao"                   { return T_SENAO; }
"enquanto"                { return T_ENQUANTO; }
"faca"                    { return T_FACA; }

"escrever"                { return T_ESCREVER; }

"decolar"                 { return T_DECOLAR; }
"pousar"                  { return T_POUSAR; }
"acelerar"                { return T_ACELERAR; }
"frear"                   { return T_FREAR; }
"subir"                   { return T_SUBIR; }
"descer"                  { return T_DESCER; }
"girar"                   { return T_GIRAR; }

"COMBUSTIVEL"             { return T_COMBUSTIVEL; }
"CLIMA"                   { return T_CLIMA; }
"ALTITUDE"                { return T_ALTITUDE; }
"VELOCIDADE"              { return T_VELOCIDADE; }

\"(esquerda|direita)\"    { yylval->sval = sdup(yytext); return T_DIRECTION; }

[0-9]+                    { yylval->ival = strtoll(yytext, NULL, 10); return T_NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*    { yylval->sval = sdup(yytext); return T_IDENT; }

":="                      { return T_ASSIGN; }
"=="                      { return T_EQEQ; }

";"                       { return ';'; }
"{"                       { return '{'; }
"}"                       { return '}'; }
"("                       { return '('; }
")"                       { return ')'; }
"+"                       { return '+'; }
"-"                       { return '-'; }
"*"                       { return '*'; }
"/"                       { return '/'; }
">"                       { return '>'; }
"<"                       { return '<'; }

.                         { return T_ERROR; }

%%
