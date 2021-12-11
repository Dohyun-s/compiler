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
    ERROR = 258,
    NAME = 259,
    NUMBER = 260,
    ADDOP = 261,
    RELOP = 262,
    LEFT = 263,
    RIGHT = 264,
    LOG = 265,
    LN = 266,
    EXP = 267,
    FAC = 268,
    MOD = 269,
    SIN = 270,
    COS = 271,
    TAN = 272,
    CSC = 273,
    SEC = 274,
    COT = 275,
    ASIN = 276,
    ACOS = 277,
    ATAN = 278,
    E = 279,
    PI = 280,
    UMINUS = 281,
    UPLUS = 282
  };
#endif
/* Tokens.  */
#define ERROR 258
#define NAME 259
#define NUMBER 260
#define ADDOP 261
#define RELOP 262
#define LEFT 263
#define RIGHT 264
#define LOG 265
#define LN 266
#define EXP 267
#define FAC 268
#define MOD 269
#define SIN 270
#define COS 271
#define TAN 272
#define CSC 273
#define SEC 274
#define COT 275
#define ASIN 276
#define ACOS 277
#define ATAN 278
#define E 279
#define PI 280
#define UMINUS 281
#define UPLUS 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "variable.y"

                double dval;
                struct symtab *symp;
		char STRING[100];
        

#line 118 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
