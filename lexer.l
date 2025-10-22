%option noyywrap
%option yylineno
%option nodefault
%option reentrant
%option bison-bridge
%option yymore

%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
  int col;
} yyg_extra_t;

static int yycolumn = 1;

static char* sdup(const char* s) {
  if (!s) return NULL;
  size_t n = strlen(s) + 1;
  char* p = (char*)malloc(n);
  if (p) memcpy(p, s, n);
  return p;
}

/* Marca a coluna inicial do lexema e atualiza coluna corrente */
#define YY_USER_ACTION do { \
  yyg_extra_t* ex = (yyg_extra_t*)yyget_extra(yyscanner); \
  if (ex) ex->col = yycolumn; \
  yycolumn += yyleng; \
} while(0)

#define RESET_COL() do { yycolumn = 1; } while(0)
%}

/* ======= REGRAS ======= */

/* Palavras-chave (declarações/controle) */
KW_INT          inteiro
KW_SE           se
KW_ENTAO        entao
KW_SENAO        senao
KW_ENQUANTO     enquanto
KW_FACA         faca

/* IO */
KW_ESCREVER     escrever

/* Ações */
KW_DECOLAR      decolar
KW_POUSAR       pousar
KW_ACELERAR     acelerar
KW_FREAR        frear
KW_SUBIR        subir
KW_DESCER       descer
KW_GIRAR        girar

/* Sensores/Registradores */
KW_COMBUSTIVEL  COMBUSTIVEL
KW_CLIMA        CLIMA
KW_ALTITUDE     ALTITUDE
KW_VELOCIDADE   VELOCIDADE

/* Direções (strings restritas) */
DIR_STR         \"(esquerda|direita)\"

/* Tokens básicos */
ID              [a-zA-Z_][a-zA-Z0-9_]*
NUM             [0-9]+

/* Espaço/comentários */
WS              [ \t\r]+
NL              \n
SL_COMMENT      //[^\n]*
ML_START        /\*
ML_END          \*/

%x COMMENT

%%

{WS}            { /* ignora */ }
{NL}            { RESET_COL(); }

{SL_COMMENT}    { /* ignora linha */ }
{ML_START}      { BEGIN(COMMENT); }
<COMMENT>{ML_END} { BEGIN(INITIAL); }
<COMMENT>{NL}   { RESET_COL(); }
<COMMENT>.      { /* consome */ }

/* Palavras-chave */
{KW_INT}        { return T_INTEIRO; }
{KW_SE}         { return T_SE; }
{KW_ENTAO}      { return T_ENTAO; }
{KW_SENAO}      { return T_SENAO; }
{KW_ENQUANTO}   { return T_ENQUANTO; }
{KW_FACA}       { return T_FACA; }

{KW_ESCREVER}   { return T_ESCREVER; }

/* Ações */
{KW_DECOLAR}    { return T_DECOLAR; }
{KW_POUSAR}     { return T_POUSAR; }
{KW_ACELERAR}   { return T_ACELERAR; }
{KW_FREAR}      { return T_FREAR; }
{KW_SUBIR}      { return T_SUBIR; }
{KW_DESCER}     { return T_DESCER; }
{KW_GIRAR}      { return T_GIRAR; }

/* Sensores */
{KW_COMBUSTIVEL}{ return T_COMBUSTIVEL; }
{KW_CLIMA}      { return T_CLIMA; }
{KW_ALTITUDE}   { return T_ALTITUDE; }
{KW_VELOCIDADE} { return T_VELOCIDADE; }

/* Direções permitidas entre aspas */
{DIR_STR}       {
                   yylval->sval = sdup(yytext); /* mantém "esquerda"/"direita" */
                   return T_DIRECTION;
                }

/* Literais e IDs */
{NUM}           { yylval->ival = strtoll(yytext, NULL, 10); return T_NUMBER; }
{ID}            { yylval->sval = sdup(yytext); return T_IDENT; }

/* Operadores compostos */
":="            { return T_ASSIGN; }
"=="            { return T_EQEQ; }

/* Símbolos de 1 char (retornamos o próprio char) */
";"             { return ';'; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
">"             { return '>'; }
"<"             { return '<'; }

/* Qualquer outro caractere -> erro léxico */
.               {
                   yyg_extra_t* ex = (yyg_extra_t*)yyget_extra(yyscanner);
                   fprintf(stderr, "Erro léxico: '%s' em %d:%d\n",
                           yytext, yylineno, ex ? ex->col : 1);
                   return T_ERROR;
                }

%%
