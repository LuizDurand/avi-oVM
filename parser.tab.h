/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 6 "parser.y"

  #include <stdio.h>
  #include <stdlib.h>

#line 54 "parser.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_INTEIRO = 258,               /* T_INTEIRO  */
    T_SE = 259,                    /* T_SE  */
    T_ENTAO = 260,                 /* T_ENTAO  */
    T_SENAO = 261,                 /* T_SENAO  */
    T_ENQUANTO = 262,              /* T_ENQUANTO  */
    T_FACA = 263,                  /* T_FACA  */
    T_ESCREVER = 264,              /* T_ESCREVER  */
    T_DECOLAR = 265,               /* T_DECOLAR  */
    T_POUSAR = 266,                /* T_POUSAR  */
    T_ACELERAR = 267,              /* T_ACELERAR  */
    T_FREAR = 268,                 /* T_FREAR  */
    T_SUBIR = 269,                 /* T_SUBIR  */
    T_DESCER = 270,                /* T_DESCER  */
    T_GIRAR = 271,                 /* T_GIRAR  */
    T_COMBUSTIVEL = 272,           /* T_COMBUSTIVEL  */
    T_CLIMA = 273,                 /* T_CLIMA  */
    T_ALTITUDE = 274,              /* T_ALTITUDE  */
    T_VELOCIDADE = 275,            /* T_VELOCIDADE  */
    T_DIRECTION = 276,             /* T_DIRECTION  */
    T_IDENT = 277,                 /* T_IDENT  */
    T_NUMBER = 278,                /* T_NUMBER  */
    T_ASSIGN = 279,                /* T_ASSIGN  */
    T_EQEQ = 280,                  /* T_EQEQ  */
    T_ERROR = 281,                 /* T_ERROR  */
    UMINUS = 282                   /* UMINUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 20 "parser.y"

  long long ival;
  char*     sval;

#line 103 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif




int yyparse (void* scanner);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
