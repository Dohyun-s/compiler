/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PI = 258,
    SIN = 259,
    COS = 260,
    TAN = 261,
    CSC = 262,
    SEC = 263,
    COT = 264,
    ASIN = 265,
    ACOS = 266,
    ATAN = 267,
    E = 268,
    LOG = 269,
    LN = 270,
    EXP = 271,
    FAC = 272,
    MOD = 273,
    ERROR = 274,
    NAME = 275,
    NUMBER = 276,
    LEFT = 277,
    RIGHT = 278,
    GE = 279,
    LE = 280,
    EQ = 281,
    NE = 282,
    UMINUS = 283,
    UPLUS = 284
  };
#endif
/* Tokens.  */
#define PI 258
#define SIN 259
#define COS 260
#define TAN 261
#define CSC 262
#define SEC 263
#define COT 264
#define ASIN 265
#define ACOS 266
#define ATAN 267
#define E 268
#define LOG 269
#define LN 270
#define EXP 271
#define FAC 272
#define MOD 273
#define ERROR 274
#define NAME 275
#define NUMBER 276
#define LEFT 277
#define RIGHT 278
#define GE 279
#define LE 280
#define EQ 281
#define NE 282
#define UMINUS 283
#define UPLUS 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 13 "variable.y"

                double dval;
                struct symtab *symp;
        

#line 121 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
