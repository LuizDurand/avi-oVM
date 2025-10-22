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
  int yyget_lineno(void* scanner);
}

%union {
  long long ival;
  char*     sval;
}

%token T_INTEIRO
%token T_SE T_ENTAO T_SENAO
%token T_ENQUANTO T_FACA
%token T_ESCREVER
%token T_DECOLAR T_POUSAR T_ACELERAR T_FREAR T_SUBIR T_DESCER T_GIRAR
%token T_COMBUSTIVEL T_CLIMA T_ALTITUDE T_VELOCIDADE
%token <sval> T_DIRECTION
%token <sval> T_IDENT
%token <ival> T_NUMBER
%token T_ASSIGN
%token T_EQEQ
%token T_ERROR

%left '>' '<' T_EQEQ
%left '+' '-'
%left '*' '/'
%precedence UMINUS

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
  : T_INTEIRO T_IDENT ';'
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
  : T_IDENT T_ASSIGN expression ';'
  ;

action
  : T_DECOLAR '(' ')' ';'
  | T_POUSAR  '(' ')' ';'
  | T_FREAR   '(' ')' ';'
  | T_ACELERAR '(' T_NUMBER ')' ';'
  | T_SUBIR    '(' T_NUMBER ')' ';'
  | T_DESCER   '(' T_NUMBER ')' ';'
  | T_GIRAR    '(' T_DIRECTION ')' ';'
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
  fprintf(stderr, "Erro sintático: %s na linha %d\n", msg, yyget_lineno(scanner));
}
