%define api.pure full
%define parse.error detailed
%define parse.lac full
%start program

%code requires {
  #include <stdio.h>
  #include <stdlib.h>
}

%code {
  #include <string.h>
  int yylex(YYSTYPE* yylval_param, void* scanner);
  void yyerror(void* scanner, const char* msg);
  extern int yylineno;
}

/* ====== TIPOS DE VALOR ====== */
/* Use APENAS %union (removido %define api.value.type) */
%union {
  long long ival;
  char*     sval;
}

/* ====== TOKENS ====== */
/* Palavras-chave de declaração/controle */
%token T_INTEIRO
%token T_SE T_ENTAO T_SENAO
%token T_ENQUANTO T_FACA

/* IO */
%token T_ESCREVER

/* Ações */
%token T_DECOLAR T_POUSAR T_ACELERAR T_FREAR T_SUBIR T_DESCER T_GIRAR

/* Sensores */
%token T_COMBUSTIVEL T_CLIMA T_ALTITUDE T_VELOCIDADE

/* Direção "esquerda"/"direita" (string restrita) */
%token <sval> T_DIRECTION

/* Básicos */
%token <sval> T_IDENT
%token <ival> T_NUMBER
%token T_ASSIGN
%token T_EQEQ
%token T_ERROR

/* Precedências (expressões) */
%left '>' '<' T_EQEQ
%left '+' '-'
%left '*' '/'
%precedence UMINUS   /* só precedência, sem associatividade */

/* scanner reentrante */
%param { void* scanner }

%%

program
  : items_opt
  ;

items_opt
  : %empty
  | items_opt item
  ;

item
  : declaration
  | statement
  ;

declaration
  : T_INTEIRO T_IDENT ';'                      { /* inteiro x; */ }
  ;

statement
  : assign
  | action
  | conditional
  | loop
  | io
  | block
  ;

assign
  : T_IDENT T_ASSIGN expression ';'            { /* x := expr; */ }
  ;

action
  : T_DECOLAR '(' ')' ';'                      { /* decolar(); */ }
  | T_POUSAR  '(' ')' ';'                      { /* pousar();  */ }
  | T_FREAR   '(' ')' ';'                      { /* frear();   */ }
  | T_ACELERAR '(' T_NUMBER ')' ';'            { /* acelerar(10); */ }
  | T_SUBIR    '(' T_NUMBER ')' ';'            { /* subir(1000);  */ }
  | T_DESCER   '(' T_NUMBER ')' ';'            { /* descer(500);  */ }
  | T_GIRAR    '(' T_DIRECTION ')' ';'         { /* girar("esquerda"); */ }
  ;

conditional
  : T_SE expression T_ENTAO block
  | T_SE expression T_ENTAO block T_SENAO block
  ;

loop
  : T_ENQUANTO expression T_FACA block
  ;

io
  : T_ESCREVER '(' expression ')' ';'
  ;

block
  : '{' statements_opt '}'
  ;

statements_opt
  : %empty
  | statements_opt statement
  ;

/* ===== EXPRESSÕES ===== */
expression
  : expression '+' expression
  | expression '-' expression
  | expression '*' expression
  | expression '/' expression
  | expression '>' expression
  | expression '<' expression
  | expression T_EQEQ expression
  | '-' expression %prec UMINUS
  | '(' expression ')'
  | T_NUMBER
  | T_IDENT
  | sensor
  ;

sensor
  : T_COMBUSTIVEL
  | T_CLIMA
  | T_ALTITUDE
  | T_VELOCIDADE
  ;

%%

void yyerror(void* scanner, const char* msg) {
  fprintf(stderr, "Erro sintático: %s na linha %d\n", msg, yylineno);
}
