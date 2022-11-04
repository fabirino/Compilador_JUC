/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "jucompiler.y"

    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fabio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "tree.h"
    
    int yylex(void);
    void yyerror (const char *s);
    extern int mostraTree;
    char message[256];
    int debug = 1; //DEBUG: variavel apenas para debug!!!

#line 86 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
    struct node *node;

#line 240 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_AND = 3,                        /* AND  */
  YYSYMBOL_ASSIGN = 4,                     /* ASSIGN  */
  YYSYMBOL_STAR = 5,                       /* STAR  */
  YYSYMBOL_COMMA = 6,                      /* COMMA  */
  YYSYMBOL_DIV = 7,                        /* DIV  */
  YYSYMBOL_EQ = 8,                         /* EQ  */
  YYSYMBOL_GE = 9,                         /* GE  */
  YYSYMBOL_GT = 10,                        /* GT  */
  YYSYMBOL_LBRACE = 11,                    /* LBRACE  */
  YYSYMBOL_LE = 12,                        /* LE  */
  YYSYMBOL_LPAR = 13,                      /* LPAR  */
  YYSYMBOL_LSQ = 14,                       /* LSQ  */
  YYSYMBOL_LT = 15,                        /* LT  */
  YYSYMBOL_MINUS = 16,                     /* MINUS  */
  YYSYMBOL_MOD = 17,                       /* MOD  */
  YYSYMBOL_NE = 18,                        /* NE  */
  YYSYMBOL_NOT = 19,                       /* NOT  */
  YYSYMBOL_OR = 20,                        /* OR  */
  YYSYMBOL_PLUS = 21,                      /* PLUS  */
  YYSYMBOL_RBRACE = 22,                    /* RBRACE  */
  YYSYMBOL_RPAR = 23,                      /* RPAR  */
  YYSYMBOL_RSQ = 24,                       /* RSQ  */
  YYSYMBOL_SEMICOLON = 25,                 /* SEMICOLON  */
  YYSYMBOL_LSHIFT = 26,                    /* LSHIFT  */
  YYSYMBOL_RSHIFT = 27,                    /* RSHIFT  */
  YYSYMBOL_XOR = 28,                       /* XOR  */
  YYSYMBOL_BOOL = 29,                      /* BOOL  */
  YYSYMBOL_CLASS = 30,                     /* CLASS  */
  YYSYMBOL_DOUBLE = 31,                    /* DOUBLE  */
  YYSYMBOL_ELSE = 32,                      /* ELSE  */
  YYSYMBOL_IF = 33,                        /* IF  */
  YYSYMBOL_INT = 34,                       /* INT  */
  YYSYMBOL_PRINT = 35,                     /* PRINT  */
  YYSYMBOL_PARSEINT = 36,                  /* PARSEINT  */
  YYSYMBOL_PUBLIC = 37,                    /* PUBLIC  */
  YYSYMBOL_RETURN = 38,                    /* RETURN  */
  YYSYMBOL_STATIC = 39,                    /* STATIC  */
  YYSYMBOL_VOID = 40,                      /* VOID  */
  YYSYMBOL_WHILE = 41,                     /* WHILE  */
  YYSYMBOL_ID = 42,                        /* ID  */
  YYSYMBOL_STRLIT = 43,                    /* STRLIT  */
  YYSYMBOL_REALLIT = 44,                   /* REALLIT  */
  YYSYMBOL_INTLIT = 45,                    /* INTLIT  */
  YYSYMBOL_BOOLLIT = 46,                   /* BOOLLIT  */
  YYSYMBOL_DOTLENGTH = 47,                 /* DOTLENGTH  */
  YYSYMBOL_STRING = 48,                    /* STRING  */
  YYSYMBOL_YYACCEPT = 49,                  /* $accept  */
  YYSYMBOL_Program = 50,                   /* Program  */
  YYSYMBOL_Declarations = 51,              /* Declarations  */
  YYSYMBOL_MethodDecl = 52,                /* MethodDecl  */
  YYSYMBOL_FieldDecl = 53,                 /* FieldDecl  */
  YYSYMBOL_Variaveis = 54,                 /* Variaveis  */
  YYSYMBOL_Type = 55,                      /* Type  */
  YYSYMBOL_MethodHeader = 56,              /* MethodHeader  */
  YYSYMBOL_FormalParams = 57,              /* FormalParams  */
  YYSYMBOL_Parametros = 58,                /* Parametros  */
  YYSYMBOL_MethodBody = 59,                /* MethodBody  */
  YYSYMBOL_Expressao = 60,                 /* Expressao  */
  YYSYMBOL_VarDecl = 61,                   /* VarDecl  */
  YYSYMBOL_Statement = 62,                 /* Statement  */
  YYSYMBOL_Gramatica = 63,                 /* Gramatica  */
  YYSYMBOL_MethodInvocation = 64,          /* MethodInvocation  */
  YYSYMBOL_CommaExpr = 65,                 /* CommaExpr  */
  YYSYMBOL_Assignment = 66,                /* Assignment  */
  YYSYMBOL_ParseArgs = 67,                 /* ParseArgs  */
  YYSYMBOL_Expr = 68                       /* Expr  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   579

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  49
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  20
/* YYNRULES -- Number of rules.  */
#define YYNRULES  87
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  177

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   303


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    72,    72,    73,    76,    77,    78,    79,    80,    81,
      84,    86,    87,    88,    91,    92,    95,    96,    97,   100,
     101,   102,   103,   106,   107,   108,   111,   112,   115,   116,
     119,   120,   121,   122,   125,   126,   129,   130,   131,   132,
     133,   134,   135,   136,   137,   138,   139,   140,   143,   144,
     145,   148,   149,   150,   153,   154,   157,   160,   161,   164,
     165,   166,   167,   168,   169,   170,   171,   172,   173,   174,
     175,   176,   177,   178,   179,   180,   181,   182,   183,   184,
     185,   186,   187,   188,   189,   190,   191,   192
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "AND", "ASSIGN",
  "STAR", "COMMA", "DIV", "EQ", "GE", "GT", "LBRACE", "LE", "LPAR", "LSQ",
  "LT", "MINUS", "MOD", "NE", "NOT", "OR", "PLUS", "RBRACE", "RPAR", "RSQ",
  "SEMICOLON", "LSHIFT", "RSHIFT", "XOR", "BOOL", "CLASS", "DOUBLE",
  "ELSE", "IF", "INT", "PRINT", "PARSEINT", "PUBLIC", "RETURN", "STATIC",
  "VOID", "WHILE", "ID", "STRLIT", "REALLIT", "INTLIT", "BOOLLIT",
  "DOTLENGTH", "STRING", "$accept", "Program", "Declarations",
  "MethodDecl", "FieldDecl", "Variaveis", "Type", "MethodHeader",
  "FormalParams", "Parametros", "MethodBody", "Expressao", "VarDecl",
  "Statement", "Gramatica", "MethodInvocation", "CommaExpr", "Assignment",
  "ParseArgs", "Expr", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-43)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     -17,   -36,    42,    34,   -43,     7,    22,   -43,   -43,    13,
      11,   -43,   -43,   -43,    89,   -43,   -43,   -43,   -43,   -43,
     -43,   -43,    16,    20,    69,    70,    18,   149,   -43,    58,
      48,    65,   -43,    12,    66,   201,   -43,   -43,    80,    84,
      88,   231,    91,   108,    82,   175,   -43,   -43,    86,   -43,
     -43,   -43,   -43,   112,    85,   105,   -43,   -43,   110,    94,
     -43,   -43,   -43,   113,   278,   244,     4,    40,   278,   278,
     278,   -43,     3,   -43,   -43,   -43,   -43,   -43,   -43,   322,
     278,   278,   121,    24,   -43,   -43,   -43,   -43,   114,   133,
     -43,   -43,   -43,   -43,   348,   120,   374,   122,   137,   129,
     400,    93,   -43,    93,   -43,   278,   278,   278,   278,   278,
     278,   278,   278,   278,   278,   278,   278,   278,   -43,   278,
     278,   278,   426,   478,   130,   -43,    28,   478,   -43,    29,
     116,    26,   148,   213,   131,   134,   -43,   278,   -43,   -43,
     528,   -43,   -43,   291,   172,   172,   172,   172,    93,   -43,
     291,   504,    93,    98,    98,   552,   213,   -43,   278,   -43,
     -43,   -43,   119,    26,   123,   -43,   -43,   452,   -43,   478,
     -43,   126,   213,   139,   -43,   -43,   -43
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,     0,     3,     6,     0,
       0,     4,     5,    13,     0,     2,     9,     7,     8,    16,
      18,    17,     0,     0,     0,     0,     0,     0,    10,     0,
       0,     0,    11,     0,     0,     0,    29,    44,     0,     0,
       0,     0,     0,     0,     0,     0,    31,    30,     0,    48,
      49,    50,    22,     0,     0,     0,    14,    21,     0,     0,
      12,    47,    37,     0,     0,     0,     0,     0,     0,     0,
       0,    42,    83,    85,    84,    86,    79,    80,    81,     0,
       0,     0,     0,     0,    28,    33,    32,    43,     0,    24,
      20,    19,    15,    36,     0,     0,     0,     0,     0,     0,
       0,    75,    76,    77,    82,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    41,     0,
       0,     0,     0,    56,     0,    52,     0,    54,    35,     0,
       0,     0,    23,     0,     0,     0,    58,     0,    87,    78,
      64,    61,    62,    69,    70,    71,    72,    73,    60,    63,
      74,    65,    59,    67,    68,    66,     0,    53,     0,    51,
      34,    25,     0,     0,    39,    46,    45,     0,    40,    55,
      26,     0,     0,     0,    27,    38,    57
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -43,   -43,   -43,   154,   159,    87,   -14,   -43,   141,   -43,
     -43,   -43,   128,   -31,   -43,   -26,   -43,   -25,   -24,   -42
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     2,    10,    11,    12,    33,    44,    24,    55,   132,
      28,    45,    46,    47,    48,    76,   126,    77,    78,    79
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      23,    49,    50,    51,    63,    97,     3,    81,     6,    49,
      50,    51,     6,     1,    86,    54,    82,    54,    59,    49,
      50,    51,    94,    96,    30,   100,   101,   102,   103,     7,
      30,    31,     8,    15,   158,    59,    16,    60,   122,   123,
     127,    99,     4,    32,     9,     5,    98,    13,     9,   128,
     104,   159,    14,    67,   160,    19,    68,    20,    25,    69,
      21,    70,    26,   140,   141,   142,   143,   144,   145,   146,
     147,   148,   149,   150,   151,   152,    40,   153,   154,   155,
      27,    52,    72,    29,    73,    74,    75,    19,    57,    20,
      56,    61,    21,    64,    19,   167,    20,    65,   106,    21,
     107,    66,   164,   106,    80,   107,    53,    49,    50,    51,
     114,    87,    81,    53,   113,   114,   169,   162,    19,   117,
      20,    82,   124,    21,    83,   168,    88,    89,    90,    22,
      49,    50,    51,    91,    67,    93,    92,    68,   130,   131,
      69,   175,    70,   134,   125,   136,    49,    50,    51,   171,
      34,   137,   138,   157,   163,   172,   165,    40,   161,   166,
      35,   170,   176,    72,    17,    73,    74,    75,   174,    18,
     129,    36,    58,    85,    37,     0,    34,   106,    19,   107,
      20,     0,    38,    21,    39,    40,    35,    41,   113,   114,
      42,    43,     0,   117,     0,     0,     0,    84,   119,   120,
      37,     0,    34,     0,    19,     0,    20,     0,    38,    21,
      39,    40,    35,    41,    34,     0,    42,    43,     0,     0,
       0,     0,     0,    62,    35,     0,    37,     0,     0,     0,
       0,     0,     0,     0,    38,     0,    39,    40,    37,    41,
       0,     0,    42,    43,    67,     0,    38,    68,    39,    40,
      69,    41,    70,     0,    42,    43,    71,    67,     0,     0,
      68,     0,     0,    69,     0,    70,     0,    40,     0,     0,
       0,     0,     0,    72,     0,    73,    74,    75,     0,     0,
      40,     0,     0,     0,     0,     0,    72,    95,    73,    74,
      75,    67,     0,     0,    68,     0,   106,    69,   107,    70,
     109,   110,     0,   111,     0,     0,   112,   113,   114,     0,
       0,     0,   117,     0,    40,     0,     0,   119,   120,     0,
      72,     0,    73,    74,    75,   105,     0,   106,     0,   107,
     108,   109,   110,     0,   111,     0,     0,   112,   113,   114,
     115,     0,   116,   117,     0,     0,     0,   118,   119,   120,
     121,   105,     0,   106,     0,   107,   108,   109,   110,     0,
     111,     0,     0,   112,   113,   114,   115,     0,   116,   117,
       0,   133,     0,     0,   119,   120,   121,   105,     0,   106,
       0,   107,   108,   109,   110,     0,   111,     0,     0,   112,
     113,   114,   115,     0,   116,   117,     0,   135,     0,     0,
     119,   120,   121,   105,     0,   106,     0,   107,   108,   109,
     110,     0,   111,     0,     0,   112,   113,   114,   115,     0,
     116,   117,     0,   139,     0,     0,   119,   120,   121,   105,
       0,   106,     0,   107,   108,   109,   110,     0,   111,     0,
       0,   112,   113,   114,   115,     0,   116,   117,     0,   156,
       0,     0,   119,   120,   121,   105,     0,   106,     0,   107,
     108,   109,   110,     0,   111,     0,     0,   112,   113,   114,
     115,     0,   116,   117,     0,     0,   173,     0,   119,   120,
     121,   105,     0,   106,     0,   107,   108,   109,   110,     0,
     111,     0,     0,   112,   113,   114,   115,     0,   116,   117,
       0,     0,     0,     0,   119,   120,   121,   105,     0,   106,
       0,   107,   108,   109,   110,     0,   111,     0,     0,   112,
     113,   114,   115,     0,     0,   117,     0,     0,     0,     0,
     119,   120,   121,   106,     0,   107,   108,   109,   110,     0,
     111,     0,     0,   112,   113,   114,   115,     0,     0,   117,
       0,     0,     0,     0,   119,   120,   121,   106,     0,   107,
     108,   109,   110,     0,   111,     0,     0,   112,   113,   114,
     115,     0,     0,   117,     0,     0,     0,     0,   119,   120
};

static const yytype_int16 yycheck[] =
{
      14,    27,    27,    27,    35,     1,    42,     4,     1,    35,
      35,    35,     1,    30,    45,    29,    13,    31,     6,    45,
      45,    45,    64,    65,     6,    67,    68,    69,    70,    22,
       6,    13,    25,    22,     6,     6,    25,    25,    80,    81,
      82,     1,     0,    25,    37,    11,    42,    25,    37,    25,
      47,    23,    39,    13,    25,    29,    16,    31,    42,    19,
      34,    21,    42,   105,   106,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,    36,   119,   120,   121,
      11,    23,    42,    13,    44,    45,    46,    29,    23,    31,
      42,    25,    34,    13,    29,   137,    31,    13,     5,    34,
       7,    13,   133,     5,    13,     7,    48,   133,   133,   133,
      17,    25,     4,    48,    16,    17,   158,   131,    29,    21,
      31,    13,     1,    34,    42,   156,    14,    42,    23,    40,
     156,   156,   156,    23,    13,    22,    42,    16,    24,     6,
      19,   172,    21,    23,    23,    23,   172,   172,   172,   163,
       1,    14,    23,    23,     6,    32,    25,    36,    42,    25,
      11,    42,    23,    42,    10,    44,    45,    46,    42,    10,
      83,    22,    31,    45,    25,    -1,     1,     5,    29,     7,
      31,    -1,    33,    34,    35,    36,    11,    38,    16,    17,
      41,    42,    -1,    21,    -1,    -1,    -1,    22,    26,    27,
      25,    -1,     1,    -1,    29,    -1,    31,    -1,    33,    34,
      35,    36,    11,    38,     1,    -1,    41,    42,    -1,    -1,
      -1,    -1,    -1,    22,    11,    -1,    25,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    33,    -1,    35,    36,    25,    38,
      -1,    -1,    41,    42,    13,    -1,    33,    16,    35,    36,
      19,    38,    21,    -1,    41,    42,    25,    13,    -1,    -1,
      16,    -1,    -1,    19,    -1,    21,    -1,    36,    -1,    -1,
      -1,    -1,    -1,    42,    -1,    44,    45,    46,    -1,    -1,
      36,    -1,    -1,    -1,    -1,    -1,    42,    43,    44,    45,
      46,    13,    -1,    -1,    16,    -1,     5,    19,     7,    21,
       9,    10,    -1,    12,    -1,    -1,    15,    16,    17,    -1,
      -1,    -1,    21,    -1,    36,    -1,    -1,    26,    27,    -1,
      42,    -1,    44,    45,    46,     3,    -1,     5,    -1,     7,
       8,     9,    10,    -1,    12,    -1,    -1,    15,    16,    17,
      18,    -1,    20,    21,    -1,    -1,    -1,    25,    26,    27,
      28,     3,    -1,     5,    -1,     7,     8,     9,    10,    -1,
      12,    -1,    -1,    15,    16,    17,    18,    -1,    20,    21,
      -1,    23,    -1,    -1,    26,    27,    28,     3,    -1,     5,
      -1,     7,     8,     9,    10,    -1,    12,    -1,    -1,    15,
      16,    17,    18,    -1,    20,    21,    -1,    23,    -1,    -1,
      26,    27,    28,     3,    -1,     5,    -1,     7,     8,     9,
      10,    -1,    12,    -1,    -1,    15,    16,    17,    18,    -1,
      20,    21,    -1,    23,    -1,    -1,    26,    27,    28,     3,
      -1,     5,    -1,     7,     8,     9,    10,    -1,    12,    -1,
      -1,    15,    16,    17,    18,    -1,    20,    21,    -1,    23,
      -1,    -1,    26,    27,    28,     3,    -1,     5,    -1,     7,
       8,     9,    10,    -1,    12,    -1,    -1,    15,    16,    17,
      18,    -1,    20,    21,    -1,    -1,    24,    -1,    26,    27,
      28,     3,    -1,     5,    -1,     7,     8,     9,    10,    -1,
      12,    -1,    -1,    15,    16,    17,    18,    -1,    20,    21,
      -1,    -1,    -1,    -1,    26,    27,    28,     3,    -1,     5,
      -1,     7,     8,     9,    10,    -1,    12,    -1,    -1,    15,
      16,    17,    18,    -1,    -1,    21,    -1,    -1,    -1,    -1,
      26,    27,    28,     5,    -1,     7,     8,     9,    10,    -1,
      12,    -1,    -1,    15,    16,    17,    18,    -1,    -1,    21,
      -1,    -1,    -1,    -1,    26,    27,    28,     5,    -1,     7,
       8,     9,    10,    -1,    12,    -1,    -1,    15,    16,    17,
      18,    -1,    -1,    21,    -1,    -1,    -1,    -1,    26,    27
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    30,    50,    42,     0,    11,     1,    22,    25,    37,
      51,    52,    53,    25,    39,    22,    25,    52,    53,    29,
      31,    34,    40,    55,    56,    42,    42,    11,    59,    13,
       6,    13,    25,    54,     1,    11,    22,    25,    33,    35,
      36,    38,    41,    42,    55,    60,    61,    62,    63,    64,
      66,    67,    23,    48,    55,    57,    42,    23,    57,     6,
      25,    25,    22,    62,    13,    13,    13,    13,    16,    19,
      21,    25,    42,    44,    45,    46,    64,    66,    67,    68,
      13,     4,    13,    42,    22,    61,    62,    25,    14,    42,
      23,    23,    42,    22,    68,    43,    68,     1,    42,     1,
      68,    68,    68,    68,    47,     3,     5,     7,     8,     9,
      10,    12,    15,    16,    17,    18,    20,    21,    25,    26,
      27,    28,    68,    68,     1,    23,    65,    68,    25,    54,
      24,     6,    58,    23,    23,    23,    23,    14,    23,    23,
      68,    68,    68,    68,    68,    68,    68,    68,    68,    68,
      68,    68,    68,    68,    68,    68,    23,    23,     6,    23,
      25,    42,    55,     6,    62,    25,    25,    68,    62,    68,
      42,    55,    32,    24,    42,    62,    23
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    49,    50,    50,    51,    51,    51,    51,    51,    51,
      52,    53,    53,    53,    54,    54,    55,    55,    55,    56,
      56,    56,    56,    57,    57,    57,    58,    58,    59,    59,
      60,    60,    60,    60,    61,    61,    62,    62,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    63,    63,
      63,    64,    64,    64,    65,    65,    66,    67,    67,    68,
      68,    68,    68,    68,    68,    68,    68,    68,    68,    68,
      68,    68,    68,    68,    68,    68,    68,    68,    68,    68,
      68,    68,    68,    68,    68,    68,    68,    68
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     5,     4,     1,     1,     1,     2,     2,     2,
       4,     5,     6,     2,     2,     3,     1,     1,     1,     5,
       5,     4,     4,     3,     2,     4,     3,     4,     3,     2,
       1,     1,     2,     2,     4,     3,     3,     2,     7,     5,
       5,     3,     2,     2,     1,     5,     5,     2,     1,     1,
       1,     4,     3,     4,     1,     3,     3,     7,     4,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     2,     2,     2,     3,     1,
       1,     1,     2,     1,     1,     1,     1,     3
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* Program: CLASS ID LBRACE Declarations RBRACE  */
#line 72 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Program"); sprintf(message,"Id(%s)",(yyvsp[-3].id)); (yyval.node)->child = newNode(strdup(message));  addBrother((yyval.node)->child, (yyvsp[-1].node));if(debug){printf("Program1\n Valor do mostraTree: %d\n\n\n", mostraTree);} if(mostraTree ){printTree((yyval.node),0);} else {freeTree((yyval.node));}}
#line 1478 "y.tab.c"
    break;

  case 3: /* Program: CLASS ID LBRACE RBRACE  */
#line 73 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Program"); sprintf(message,"Id(%s)",(yyvsp[-2].id)); (yyval.node)->child = newNode(strdup(message)); if(mostraTree){printTree((yyval.node),0);} else {freeTree((yyval.node));}if(debug)printf("Program2\n");}
#line 1484 "y.tab.c"
    break;

  case 4: /* Declarations: MethodDecl  */
#line 76 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Declarations1\n");}
#line 1490 "y.tab.c"
    break;

  case 5: /* Declarations: FieldDecl  */
#line 77 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Declarations2\n");}
#line 1496 "y.tab.c"
    break;

  case 6: /* Declarations: SEMICOLON  */
#line 78 "jucompiler.y"
                                                                            {if(debug)printf("Declarations3\n");}
#line 1502 "y.tab.c"
    break;

  case 7: /* Declarations: Declarations MethodDecl  */
#line 79 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); addBrother((yyval.node), (yyvsp[0].node));if(debug)printf("Declarations4\n");}
#line 1508 "y.tab.c"
    break;

  case 8: /* Declarations: Declarations FieldDecl  */
#line 80 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); addBrother((yyval.node), (yyvsp[0].node));if(debug)printf("Declarations5\n");}
#line 1514 "y.tab.c"
    break;

  case 9: /* Declarations: Declarations SEMICOLON  */
#line 81 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node);if(debug)printf("Declarations6\n");}
#line 1520 "y.tab.c"
    break;

  case 10: /* MethodDecl: PUBLIC STATIC MethodHeader MethodBody  */
#line 84 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodDecl"); (yyval.node)->child = (yyvsp[-1].node); addBrother((yyvsp[-1].node),(yyvsp[0].node));if(debug)printf("MethodDecl1\n");}
#line 1526 "y.tab.c"
    break;

  case 11: /* FieldDecl: PUBLIC STATIC Type ID SEMICOLON  */
#line 86 "jucompiler.y"
                                                                            {(yyval.node) = newNode("FieldDecl"); sprintf(message,"Id(%s)",(yyvsp[-1].id)); (yyval.node)->child = (yyvsp[-2].node); addBrother((yyvsp[-2].node), newNode(strdup(message)));if(debug)printf("FieldDecl1\n");}
#line 1532 "y.tab.c"
    break;

  case 12: /* FieldDecl: PUBLIC STATIC Type ID Variaveis SEMICOLON  */
#line 87 "jucompiler.y"
                                                                            {(yyval.node) = newNode("FieldDecl"); sprintf(message,"Id(%s)",(yyvsp[-2].id)); (yyval.node)->child = (yyvsp[-3].node); Node *temp = newNode(strdup(message)); addBrother((yyvsp[-3].node),temp); addBrother(temp,(yyvsp[-1].node));if(debug)printf("FieldDecl2\n");}
#line 1538 "y.tab.c"
    break;

  case 13: /* FieldDecl: error SEMICOLON  */
#line 88 "jucompiler.y"
                                                                            {(yyval.node) = newNode(NULL); mostraTree=0;if(debug)printf("FieldDeclerror\n");}
#line 1544 "y.tab.c"
    break;

  case 14: /* Variaveis: COMMA ID  */
#line 91 "jucompiler.y"
                                                                            {sprintf(message,"Id(%s)",(yyvsp[0].id)); (yyval.node) = newNode(strdup(message)); if(debug)printf("Variaveis1\n");}
#line 1550 "y.tab.c"
    break;

  case 15: /* Variaveis: Variaveis COMMA ID  */
#line 92 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-2].node); sprintf(message,"Id(%s)",(yyvsp[0].id)); addBrother((yyvsp[-2].node),newNode(strdup(message))); if(debug)printf("Variaveis2\n");}
#line 1556 "y.tab.c"
    break;

  case 16: /* Type: BOOL  */
#line 95 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Bool");if(debug)printf("Type1\n");}
#line 1562 "y.tab.c"
    break;

  case 17: /* Type: INT  */
#line 96 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Int");if(debug)printf("Type2\n");}
#line 1568 "y.tab.c"
    break;

  case 18: /* Type: DOUBLE  */
#line 97 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Double");if(debug)printf("Type3\n");}
#line 1574 "y.tab.c"
    break;

  case 19: /* MethodHeader: Type ID LPAR FormalParams RPAR  */
#line 100 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodHeader"); (yyval.node)->child = (yyvsp[-4].node); sprintf(message,"Id(%s)",(yyvsp[-3].id)); Node *aux = newNode(strdup(message));addBrother((yyvsp[-4].node),aux);addBrother(aux,(yyvsp[-1].node));if(debug)printf("MethodHeader1\n");}
#line 1580 "y.tab.c"
    break;

  case 20: /* MethodHeader: VOID ID LPAR FormalParams RPAR  */
#line 101 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodHeader"); (yyval.node)->child = newNode("Void"); sprintf(message,"Id(%s)",(yyvsp[-3].id)); Node *aux = newNode(strdup(message));addBrother((yyval.node)->child,aux);addBrother(aux,(yyvsp[-1].node));if(debug)printf("MethodHeader2\n");}
#line 1586 "y.tab.c"
    break;

  case 21: /* MethodHeader: Type ID LPAR RPAR  */
#line 102 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodHeader"); (yyval.node)->child = (yyvsp[-3].node); sprintf(message,"Id(%s)",(yyvsp[-2].id));addBrother((yyvsp[-3].node),newNode(strdup(message))); if(debug)printf("MethodHeader3\n");}
#line 1592 "y.tab.c"
    break;

  case 22: /* MethodHeader: VOID ID LPAR RPAR  */
#line 103 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodHeader"); (yyval.node)->child = newNode("Void"); sprintf(message,"Id(%s)",(yyvsp[-2].id)); addBrother((yyval.node)->child,newNode(strdup(message))); if(debug)printf("MethodHeader4\n");}
#line 1598 "y.tab.c"
    break;

  case 23: /* FormalParams: Type ID Parametros  */
#line 106 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-2].node); sprintf(message,"Id(%s)",(yyvsp[-1].id)); Node *temp = newNode(strdup(message)); addBrother((yyvsp[-2].node),temp); addBrother(temp,(yyvsp[0].node));if(debug)printf("FormalParams1\n");}
#line 1604 "y.tab.c"
    break;

  case 24: /* FormalParams: Type ID  */
#line 107 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); sprintf(message,"Id(%s)",(yyvsp[0].id)); Node *temp = newNode(strdup(message)); addBrother((yyvsp[-1].node),temp);if(debug)printf("FormalParams2\n");}
#line 1610 "y.tab.c"
    break;

  case 25: /* FormalParams: STRING LSQ RSQ ID  */
#line 108 "jucompiler.y"
                                                                            {(yyval.node) = newNode("StringArray"); sprintf(message,"Id(%s)",(yyvsp[0].id));addBrother((yyval.node),newNode(strdup(message)));if(debug)printf("FormalParams3\n");}
#line 1616 "y.tab.c"
    break;

  case 26: /* Parametros: COMMA Type ID  */
#line 111 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); sprintf(message,"Id(%s)",(yyvsp[0].id)); addBrother((yyvsp[-1].node), newNode(strdup(message)));if(debug)printf("Parametros1\n");}
#line 1622 "y.tab.c"
    break;

  case 27: /* Parametros: Parametros COMMA Type ID  */
#line 112 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-3].node); addBrother((yyvsp[-3].node),(yyvsp[-1].node)); sprintf(message,"Id(%s)",(yyvsp[0].id)); addBrother((yyvsp[-1].node),newNode(strdup(message)));if(debug)printf("Parametros2\n");}
#line 1628 "y.tab.c"
    break;

  case 28: /* MethodBody: LBRACE Expressao RBRACE  */
#line 115 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodBody"); (yyval.node)->child = (yyvsp[-1].node);if(debug)printf("MethodBody1\n");}
#line 1634 "y.tab.c"
    break;

  case 29: /* MethodBody: LBRACE RBRACE  */
#line 116 "jucompiler.y"
                                                                            {(yyval.node) = newNode("MethodBody");if(debug)printf("MethodBody2\n");}
#line 1640 "y.tab.c"
    break;

  case 30: /* Expressao: Statement  */
#line 119 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Expressao1\n");}
#line 1646 "y.tab.c"
    break;

  case 31: /* Expressao: VarDecl  */
#line 120 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Expressao2\n");}
#line 1652 "y.tab.c"
    break;

  case 32: /* Expressao: Expressao Statement  */
#line 121 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); addBrother((yyvsp[-1].node),(yyvsp[0].node));if(debug)printf("Expressao3\n");}
#line 1658 "y.tab.c"
    break;

  case 33: /* Expressao: Expressao VarDecl  */
#line 122 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node); addBrother((yyvsp[-1].node),(yyvsp[0].node));if(debug)printf("Expressao4\n");}
#line 1664 "y.tab.c"
    break;

  case 34: /* VarDecl: Type ID Variaveis SEMICOLON  */
#line 125 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-3].node); sprintf(message,"Id(%s)",(yyvsp[-2].id)); Node *temp = newNode(strdup(message)); addBrother((yyvsp[-3].node), temp); addBrother(temp, (yyvsp[-1].node));if(debug)printf("VarDecl1\n");}
#line 1670 "y.tab.c"
    break;

  case 35: /* VarDecl: Type ID SEMICOLON  */
#line 126 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-2].node); sprintf(message,"Id(%s)",(yyvsp[-1].id)); addBrother((yyvsp[-2].node), newNode(strdup(message)));if(debug)printf("VarDecl2\n");}
#line 1676 "y.tab.c"
    break;

  case 36: /* Statement: LBRACE Statement RBRACE  */
#line 129 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node);if(debug)printf("Statement1\n");}
#line 1682 "y.tab.c"
    break;

  case 37: /* Statement: LBRACE RBRACE  */
#line 130 "jucompiler.y"
                                                                            {if(debug)printf("Statement2\n");}
#line 1688 "y.tab.c"
    break;

  case 38: /* Statement: IF LPAR Expr RPAR Statement ELSE Statement  */
#line 131 "jucompiler.y"
                                                                            {(yyval.node) = newNode("If"); (yyval.node)->child=(yyvsp[-4].node); addBrother((yyvsp[-4].node),(yyvsp[-2].node));addBrother((yyvsp[-2].node),newNode("Block"));  addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Statement3\n");}
#line 1694 "y.tab.c"
    break;

  case 39: /* Statement: IF LPAR Expr RPAR Statement  */
#line 132 "jucompiler.y"
                                                                            {(yyval.node) = newNode("If"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));addBrother((yyvsp[0].node),newNode("Block"));if(debug)printf("Statement4\n");}
#line 1700 "y.tab.c"
    break;

  case 40: /* Statement: WHILE LPAR Expr RPAR Statement  */
#line 133 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-2].node); addBrother((yyvsp[-2].node), (yyvsp[0].node));if(debug)printf("Statement5\n");}
#line 1706 "y.tab.c"
    break;

  case 41: /* Statement: RETURN Expr SEMICOLON  */
#line 134 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Return"); (yyval.node)->child = (yyvsp[-1].node);if(debug)printf("Statement6\n");}
#line 1712 "y.tab.c"
    break;

  case 42: /* Statement: RETURN SEMICOLON  */
#line 135 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Return"); (yyval.node)->child = NULL;if(debug)printf("Statement7\n");}
#line 1718 "y.tab.c"
    break;

  case 43: /* Statement: Gramatica SEMICOLON  */
#line 136 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node);if(debug)printf("Statement8\n");}
#line 1724 "y.tab.c"
    break;

  case 44: /* Statement: SEMICOLON  */
#line 137 "jucompiler.y"
                                                                            {;if(debug)printf("Statement9\n");}
#line 1730 "y.tab.c"
    break;

  case 45: /* Statement: PRINT LPAR Expr RPAR SEMICOLON  */
#line 138 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Print"); (yyval.node)->child = (yyvsp[-2].node);if(debug)printf("Statement10\n");}
#line 1736 "y.tab.c"
    break;

  case 46: /* Statement: PRINT LPAR STRLIT RPAR SEMICOLON  */
#line 139 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Print"); sprintf(message,"StrLit(%s)",(yyvsp[-2].id)); (yyval.node)->child = newNode(strdup(message));if(debug)printf("Statement11\n");}
#line 1742 "y.tab.c"
    break;

  case 47: /* Statement: error SEMICOLON  */
#line 140 "jucompiler.y"
                                                                            {(yyval.node) = newNode(NULL); mostraTree=0;if(debug)printf("StatementError\n");}
#line 1748 "y.tab.c"
    break;

  case 48: /* Gramatica: MethodInvocation  */
#line 143 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Gramatica1\n");}
#line 1754 "y.tab.c"
    break;

  case 49: /* Gramatica: Assignment  */
#line 144 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Gramatica2\n");}
#line 1760 "y.tab.c"
    break;

  case 50: /* Gramatica: ParseArgs  */
#line 145 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Gramatica3\n");}
#line 1766 "y.tab.c"
    break;

  case 51: /* MethodInvocation: ID LPAR CommaExpr RPAR  */
#line 148 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Call");sprintf(message,"Id(%s)",(yyvsp[-3].id)); (yyval.node)->child = newNode(strdup(message)); addBrother((yyval.node)->child,(yyvsp[-1].node));if(debug)printf("MethodInvocation1\n");}
#line 1772 "y.tab.c"
    break;

  case 52: /* MethodInvocation: ID LPAR RPAR  */
#line 149 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Call");sprintf(message,"Id(%s)",(yyvsp[-2].id)); (yyval.node)->child = newNode(strdup(message));if(debug)printf("MethodInvocation2\n");}
#line 1778 "y.tab.c"
    break;

  case 53: /* MethodInvocation: ID LPAR error RPAR  */
#line 150 "jucompiler.y"
                                                                            {(yyval.node) = newNode(NULL); mostraTree=0;if(debug)printf("MethodInvocationError\n");}
#line 1784 "y.tab.c"
    break;

  case 54: /* CommaExpr: Expr  */
#line 153 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("CommaExpr1\n");}
#line 1790 "y.tab.c"
    break;

  case 55: /* CommaExpr: CommaExpr COMMA Expr  */
#line 154 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-2].node);addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("CommaExpr2\n");}
#line 1796 "y.tab.c"
    break;

  case 56: /* Assignment: ID ASSIGN Expr  */
#line 157 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Assign"); sprintf(message,"Id(%s)",(yyvsp[-2].id));(yyval.node)->child = newNode(strdup(message));addBrother((yyval.node)->child,(yyvsp[0].node));if(debug)printf("Assignment1\n");}
#line 1802 "y.tab.c"
    break;

  case 57: /* ParseArgs: PARSEINT LPAR ID LSQ Expr RSQ RPAR  */
#line 160 "jucompiler.y"
                                                                            {sprintf(message,"Id(%s)",(yyvsp[-4].id));(yyval.node) = newNode(strdup(message));addBrother((yyval.node),(yyvsp[-2].node));if(debug)printf("ParseArgs1\n");}
#line 1808 "y.tab.c"
    break;

  case 58: /* ParseArgs: PARSEINT LPAR error RPAR  */
#line 161 "jucompiler.y"
                                                                            {(yyval.node) = newNode(NULL); mostraTree=0;if(debug)printf("ParseArgsError\n");}
#line 1814 "y.tab.c"
    break;

  case 59: /* Expr: Expr PLUS Expr  */
#line 164 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Add"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr1\n");}
#line 1820 "y.tab.c"
    break;

  case 60: /* Expr: Expr MINUS Expr  */
#line 165 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Sub"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr2\n");}
#line 1826 "y.tab.c"
    break;

  case 61: /* Expr: Expr STAR Expr  */
#line 166 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Mul"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr3\n");}
#line 1832 "y.tab.c"
    break;

  case 62: /* Expr: Expr DIV Expr  */
#line 167 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Div"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr4\n");}
#line 1838 "y.tab.c"
    break;

  case 63: /* Expr: Expr MOD Expr  */
#line 168 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Mod"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr5\n");}
#line 1844 "y.tab.c"
    break;

  case 64: /* Expr: Expr AND Expr  */
#line 169 "jucompiler.y"
                                                                            {(yyval.node) = newNode("And"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr6\n");}
#line 1850 "y.tab.c"
    break;

  case 65: /* Expr: Expr OR Expr  */
#line 170 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Or"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr7\n");}
#line 1856 "y.tab.c"
    break;

  case 66: /* Expr: Expr XOR Expr  */
#line 171 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Xor"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr8\n");}
#line 1862 "y.tab.c"
    break;

  case 67: /* Expr: Expr LSHIFT Expr  */
#line 172 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Lshift"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr9\n");}
#line 1868 "y.tab.c"
    break;

  case 68: /* Expr: Expr RSHIFT Expr  */
#line 173 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Rshift"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr10\n");}
#line 1874 "y.tab.c"
    break;

  case 69: /* Expr: Expr EQ Expr  */
#line 174 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Eq"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr11\n");}
#line 1880 "y.tab.c"
    break;

  case 70: /* Expr: Expr GE Expr  */
#line 175 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Ge"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr12\n");}
#line 1886 "y.tab.c"
    break;

  case 71: /* Expr: Expr GT Expr  */
#line 176 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Gt"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr13\n");}
#line 1892 "y.tab.c"
    break;

  case 72: /* Expr: Expr LE Expr  */
#line 177 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Le"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr14\n");}
#line 1898 "y.tab.c"
    break;

  case 73: /* Expr: Expr LT Expr  */
#line 178 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Lt"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr15\n");}
#line 1904 "y.tab.c"
    break;

  case 74: /* Expr: Expr NE Expr  */
#line 179 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Ne"); (yyval.node)->child=(yyvsp[-2].node); addBrother((yyvsp[-2].node),(yyvsp[0].node));if(debug)printf("Expr16\n");}
#line 1910 "y.tab.c"
    break;

  case 75: /* Expr: MINUS Expr  */
#line 180 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Minus"); (yyval.node)->child=(yyvsp[0].node);if(debug)printf("Expr17\n");}
#line 1916 "y.tab.c"
    break;

  case 76: /* Expr: NOT Expr  */
#line 181 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Not"); (yyval.node)->child=(yyvsp[0].node);if(debug)printf("Expr18\n");}
#line 1922 "y.tab.c"
    break;

  case 77: /* Expr: PLUS Expr  */
#line 182 "jucompiler.y"
                                                                            {(yyval.node) = newNode("Plus"); (yyval.node)->child=(yyvsp[0].node);if(debug)printf("Expr19\n");}
#line 1928 "y.tab.c"
    break;

  case 78: /* Expr: LPAR Expr RPAR  */
#line 183 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[-1].node);if(debug)printf("Expr20\n");}
#line 1934 "y.tab.c"
    break;

  case 79: /* Expr: MethodInvocation  */
#line 184 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Expr21\n");}
#line 1940 "y.tab.c"
    break;

  case 80: /* Expr: Assignment  */
#line 185 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Expr22\n");}
#line 1946 "y.tab.c"
    break;

  case 81: /* Expr: ParseArgs  */
#line 186 "jucompiler.y"
                                                                            {(yyval.node) = (yyvsp[0].node);if(debug)printf("Expr23\n");}
#line 1952 "y.tab.c"
    break;

  case 82: /* Expr: ID DOTLENGTH  */
#line 187 "jucompiler.y"
                                                                            {sprintf(message,"Id(%s)",(yyvsp[-1].id)); (yyval.node) = newNode(strdup(message)); addBrother((yyval.node),  newNode("Length"));if(debug)printf("Expr24\n");}
#line 1958 "y.tab.c"
    break;

  case 83: /* Expr: ID  */
#line 188 "jucompiler.y"
                                                                            {sprintf(message,"Id(%s)",(yyvsp[0].id));(yyval.node) = newNode(strdup(message));if(debug)printf("Expr25\n");}
#line 1964 "y.tab.c"
    break;

  case 84: /* Expr: INTLIT  */
#line 189 "jucompiler.y"
                                                                            {sprintf(message, "DecLit(%s)", (yyvsp[0].id));(yyval.node) = newNode(strdup(message));if(debug)printf("Expr26\n");}
#line 1970 "y.tab.c"
    break;

  case 85: /* Expr: REALLIT  */
#line 190 "jucompiler.y"
                                                                            {sprintf(message, "RealLit(%s)", (yyvsp[0].id));(yyval.node) = newNode(strdup(message));if(debug)printf("Expr27\n");}
#line 1976 "y.tab.c"
    break;

  case 86: /* Expr: BOOLLIT  */
#line 191 "jucompiler.y"
                                                                            {sprintf(message, "BoolLit(%s)", (yyvsp[0].id));(yyval.node) = newNode(strdup(message));if(debug)printf("Expr28\n");}
#line 1982 "y.tab.c"
    break;

  case 87: /* Expr: LPAR error RPAR  */
#line 192 "jucompiler.y"
                                                                            {(yyval.node) = newNode(NULL); mostraTree=0;if(debug)printf("ExprError\n");}
#line 1988 "y.tab.c"
    break;


#line 1992 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 195 "jucompiler.y"

