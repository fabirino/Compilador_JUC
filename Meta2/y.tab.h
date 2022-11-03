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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    AND = 258,                     /* AND  */
    ASSIGN = 259,                  /* ASSIGN  */
    STAR = 260,                    /* STAR  */
    COMMA = 261,                   /* COMMA  */
    DIV = 262,                     /* DIV  */
    EQ = 263,                      /* EQ  */
    GE = 264,                      /* GE  */
    GT = 265,                      /* GT  */
    LBRACE = 266,                  /* LBRACE  */
    LE = 267,                      /* LE  */
    LPAR = 268,                    /* LPAR  */
    LSQ = 269,                     /* LSQ  */
    LT = 270,                      /* LT  */
    MINUS = 271,                   /* MINUS  */
    MOD = 272,                     /* MOD  */
    NE = 273,                      /* NE  */
    NOT = 274,                     /* NOT  */
    OR = 275,                      /* OR  */
    PLUS = 276,                    /* PLUS  */
    RBRACE = 277,                  /* RBRACE  */
    RPAR = 278,                    /* RPAR  */
    RSQ = 279,                     /* RSQ  */
    SEMICOLON = 280,               /* SEMICOLON  */
    LSHIFT = 281,                  /* LSHIFT  */
    RSHIFT = 282,                  /* RSHIFT  */
    XOR = 283,                     /* XOR  */
    BOOL = 284,                    /* BOOL  */
    CLASS = 285,                   /* CLASS  */
    DOUBLE = 286,                  /* DOUBLE  */
    ELSE = 287,                    /* ELSE  */
    IF = 288,                      /* IF  */
    INT = 289,                     /* INT  */
    PRINT = 290,                   /* PRINT  */
    PARSEINT = 291,                /* PARSEINT  */
    PUBLIC = 292,                  /* PUBLIC  */
    RETURN = 293,                  /* RETURN  */
    STATIC = 294,                  /* STATIC  */
    VOID = 295,                    /* VOID  */
    WHILE = 296,                   /* WHILE  */
    ID = 297,                      /* ID  */
    STRLIT = 298,                  /* STRLIT  */
    REALLIT = 299,                 /* REALLIT  */
    INTLIT = 300,                  /* INTLIT  */
    BOOLLIT = 301,                 /* BOOLLIT  */
    DOTLENGTH = 302,               /* DOTLENGTH  */
    STRING = 303                   /* STRING  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define AND 258
#define ASSIGN 259
#define STAR 260
#define COMMA 261
#define DIV 262
#define EQ 263
#define GE 264
#define GT 265
#define LBRACE 266
#define LE 267
#define LPAR 268
#define LSQ 269
#define LT 270
#define MINUS 271
#define MOD 272
#define NE 273
#define NOT 274
#define OR 275
#define PLUS 276
#define RBRACE 277
#define RPAR 278
#define RSQ 279
#define SEMICOLON 280
#define LSHIFT 281
#define RSHIFT 282
#define XOR 283
#define BOOL 284
#define CLASS 285
#define DOUBLE 286
#define ELSE 287
#define IF 288
#define INT 289
#define PRINT 290
#define PARSEINT 291
#define PUBLIC 292
#define RETURN 293
#define STATIC 294
#define VOID 295
#define WHILE 296
#define ID 297
#define STRLIT 298
#define REALLIT 299
#define INTLIT 300
#define BOOLLIT 301
#define DOTLENGTH 302
#define STRING 303

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "jucompiler.y"

    char *id;
    Node *node;

#line 168 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
