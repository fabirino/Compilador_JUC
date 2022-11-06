%{
    /* ===================================================================================
	Compiladores -  Eduardo Figueiredo 2020213717
                 -  Fábio Santos       2020212310
    ====================================================================================== */
    #include "y.tab.h"
    #include "STree.h"
    #include <stdio.h>
    #include <string.h>

    int yyparse(void);

    int contador_linhas = 1;
    int contador_colunas = 1;
    int flagLexx = 0;
    int flagYacc = 0;
    int col_string =1;
    int col_comment = 1;
    int line_comment = 1;
    int mostraTree = 0;
    extern int erro; 
    extern node * raiz; 

    char aux[1024];
%}

ID                      ([a-z]|[A-Z]|"_"|"$")([a-z]|[A-Z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]
sinal                   "-"|"+"
novalinha               (\r?\n)|(\r\n?)
SCAPES                  \\[rfnt\\\"]

BOOLLIT                 "true"|"false" 
AND                     "&&"
ASSIGN                  "="
STAR                    "*"
COMMA                   ","
DIV                     "/"
EQ                      "=="
GE                      ">="
GT                      ">"
LBRACE                  "{"
LE                      "<="
LPAR                    "("
LSQ                     "["
LT                      "<"
MINUS                   "-"
MOD                     "%"
NE                      "!="
NOT                     "!"
OR                      "||"
PLUS                    "+"
RBRACE                  "}"
RPAR                    ")"
RSQ                     "]"
SEMICOLON               ";"
ARROW                   "->"
LSHIFT                  "<<"
RSHIFT                  ">>"
XOR                     "^"
BOOL                    "boolean"
CLASS                   "class"
DOTLENGTH               ".length"
DOUBLE                  "double"
ELSE                    "else"
IF                      "if"
INT                     "int"
PRINT                   "System.out.print"
PARSEINT                "Integer.parseInt"
PUBLIC                  "public"
RETURN                  "return"
STATIC                  "static"
STRING                  "String"
VOID                    "void"
WHILE                   "while"

RESERVED                "++"|"--"|"null"|"Integer"|"System"|"break"|"byte"|"case"|"catch"|"char"|"const"|"enum"|"extends"|"final"|"finally"|"float"|"for"|"implements"|"import"|"instanceof"|"interface"|"long"|"native"|"new"|"protected"|"short"|"strictfp"|"super"|"this"|"throw"|"throws"|"transient"|"try"|"volatile"|"abstract"|"continue"|"switch"|"assert"|"default"|"package"|"synchronized"|"do"|"goto"|"private"             

INTLIT                  ("0"|{naturais}("_"*({inteiros}+))*)

REALLIT1                (("_"*{inteiros}+))+(".")?("e"|"E"){sinal}?{inteiros}("_"*{inteiros}+)* 
REALLIT2                (("_"*{inteiros}+))+"."(("_"*{inteiros}+)+(("e"|"E"){sinal}?("_"*{inteiros}+)+)?)? 
REALLIT3                "."("_"*{inteiros}+)+(("e"|"E"){sinal}?("_"*{inteiros}+)+)?   
REALLIT                 {REALLIT1}|{REALLIT2}|{REALLIT3}


%X COMMENT STRING1 STRINGERROR COMMENT2  
%% 

\"                              {col_string = contador_colunas; BEGIN STRING1;}
<STRING1>{novalinha}            {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;BEGIN 0;}
<STRING1>({SCAPES}|[^\r\n\"\\])*\" {if(flagLexx)printf("STRLIT(\"%s)\n",yytext); contador_colunas+=yyleng; BEGIN 0; return STRLIT;}
<STRING1>[^\r\n\"]*\\[^f|n|r|t|\\|\"]*\"   { yyless(0); BEGIN STRINGERROR;}
<STRING1>[^\r\n\"]*{novalinha}?            { yyless(0); BEGIN STRINGERROR;}
<STRING1><<EOF>>                    {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}


<STRINGERROR>\"                  { contador_colunas+=yyleng; BEGIN 0;} 
<STRINGERROR>{novalinha}         { printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;BEGIN 0;}   
<STRINGERROR>{SCAPES}            { contador_colunas+=yyleng;}
<STRINGERROR>\\[^\n\r\\\"fnrt]   { printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}
<STRINGERROR>\\                  { printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}
<STRINGERROR><<EOF>>             { printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}
<STRINGERROR>.                   { contador_colunas+=yyleng;}

\/\*                          {col_comment = contador_colunas + yyleng;line_comment =contador_linhas;  BEGIN COMMENT;}
<COMMENT>"*/"                 {contador_colunas = col_comment + yyleng; contador_linhas =  line_comment;  BEGIN 0;}
<COMMENT>{novalinha}          {col_comment=1; line_comment++;}
<COMMENT><<EOF>>              {printf("Line %d, col %d: unterminated comment\n", contador_linhas, contador_colunas);exit(0);}
<COMMENT>.                    {col_comment+=yyleng;}

"//"                          {contador_colunas++; BEGIN COMMENT2;}                  
<COMMENT2>{novalinha}         {contador_colunas = 1;contador_linhas++; BEGIN 0;}
<COMMENT2><<EOF>>             {exit(0);}
<COMMENT2>.                   {contador_colunas+=yyleng;}


{novalinha}                   {contador_colunas=1; contador_linhas++;}

{BOOLLIT}                     {if (flagLexx) printf("BOOLLIT(%s)\n",yytext);contador_colunas+=yyleng; if(flagYacc) {yylval.id = strdup(yytext);return BOOLLIT;}}
{AND}                         {if (flagLexx) printf("AND\n");contador_colunas+=yyleng;                if(flagYacc) {return AND;}}
{ASSIGN}                      {if (flagLexx) printf("ASSIGN\n");contador_colunas+=yyleng;             if(flagYacc) {return ASSIGN;}}
{STAR}                        {if (flagLexx) printf("STAR\n");contador_colunas+=yyleng;               if(flagYacc) {return STAR;}}
{COMMA}                       {if (flagLexx) printf("COMMA\n");contador_colunas+=yyleng;              if(flagYacc) {return COMMA;}}
{DIV}                         {if (flagLexx) printf("DIV\n");contador_colunas+=yyleng;                if(flagYacc) {return DIV;}}
{EQ}                          {if (flagLexx) printf("EQ\n");contador_colunas+=yyleng;                 if(flagYacc) {return EQ;}}
{GE}                          {if (flagLexx) printf("GE\n");contador_colunas+=yyleng;                 if(flagYacc) {return GE;}}
{GT}                          {if (flagLexx) printf("GT\n");contador_colunas+=yyleng;                 if(flagYacc) {return GT;}}
{LBRACE}                      {if (flagLexx) printf("LBRACE\n");contador_colunas+=yyleng;             if(flagYacc) {return LBRACE;}}
{LE}                          {if (flagLexx) printf("LE\n");contador_colunas+=yyleng;                 if(flagYacc) {return LE;}}
{LPAR}                        {if (flagLexx) printf("LPAR\n");contador_colunas+=yyleng;               if(flagYacc) {return LPAR;}}
{LSQ}                         {if (flagLexx) printf("LSQ\n");contador_colunas+=yyleng;                if(flagYacc) {return LSQ;}}
{LT}                          {if (flagLexx) printf("LT\n");contador_colunas+=yyleng;                 if(flagYacc) {return LT;}}
{MINUS}                       {if (flagLexx) printf("MINUS\n");contador_colunas+=yyleng;              if(flagYacc) {return MINUS;}}
{MOD}                         {if (flagLexx) printf("MOD\n");contador_colunas+=yyleng;                if(flagYacc) {return MOD;}}
{NE}                          {if (flagLexx) printf("NE\n");contador_colunas+=yyleng;                 if(flagYacc) {return NE;}}
{NOT}                         {if (flagLexx) printf("NOT\n");contador_colunas+=yyleng;                if(flagYacc) {return NOT;}}
{OR}                          {if (flagLexx) printf("OR\n");contador_colunas+=yyleng;                 if(flagYacc) {return OR;}}
{PLUS}                        {if (flagLexx) printf("PLUS\n");contador_colunas+=yyleng;               if(flagYacc) {return PLUS;}}
{RBRACE}                      {if (flagLexx) printf("RBRACE\n");contador_colunas+=yyleng;             if(flagYacc) {return RBRACE;}}
{RPAR}                        {if (flagLexx) printf("RPAR\n");contador_colunas+=yyleng;               if(flagYacc) {return RPAR;}}
{RSQ}                         {if (flagLexx) printf("RSQ\n");contador_colunas+=yyleng;                if(flagYacc) {return RSQ;}}
{SEMICOLON}                   {if (flagLexx) printf("SEMICOLON\n");contador_colunas+=yyleng;          if(flagYacc) {return SEMICOLON;}}
{ARROW}                       {if (flagLexx) printf("ARROW\n");contador_colunas+=yyleng;}   
{LSHIFT}                      {if (flagLexx) printf("LSHIFT\n");contador_colunas+=yyleng;             if(flagYacc) {return LSHIFT;}}
{RSHIFT}                      {if (flagLexx) printf("RSHIFT\n");contador_colunas+=yyleng;             if(flagYacc) {return RSHIFT;}}
{XOR}                         {if (flagLexx) printf("XOR\n");contador_colunas+=yyleng;                if(flagYacc) {return XOR;}}
{BOOL}                        {if (flagLexx) printf("BOOL\n");contador_colunas+=yyleng;               if(flagYacc) {return BOOL;}}
{CLASS}                       {if (flagLexx) printf("CLASS\n");contador_colunas+=yyleng;              if(flagYacc) {return CLASS;}}
{DOTLENGTH}                   {if (flagLexx) printf("DOTLENGTH\n");contador_colunas+=yyleng;          if(flagYacc) {return DOTLENGTH;}}
{DOUBLE}                      {if (flagLexx) printf("DOUBLE\n");contador_colunas+=yyleng;             if(flagYacc) {return DOUBLE;}}
{ELSE}                        {if (flagLexx) printf("ELSE\n");contador_colunas+=yyleng;               if(flagYacc) {return ELSE;}}
{IF}                          {if (flagLexx) printf("IF\n");contador_colunas+=yyleng;                 if(flagYacc) {return IF;}}
{INT}                         {if (flagLexx) printf("INT\n");contador_colunas+=yyleng;                if(flagYacc) {return INT;}}
{PRINT}                       {if (flagLexx) printf("PRINT\n");contador_colunas+=yyleng;              if(flagYacc) {return PRINT;}}
{PARSEINT}                    {if (flagLexx) printf("PARSEINT\n");contador_colunas+=yyleng;           if(flagYacc) {return PARSEINT;}}
{PUBLIC}                      {if (flagLexx) printf("PUBLIC\n");contador_colunas+=yyleng;             if(flagYacc) {return PUBLIC;}}
{RETURN}                      {if (flagLexx) printf("RETURN\n");contador_colunas+=yyleng;             if(flagYacc) {return RETURN;}}
{STATIC}                      {if (flagLexx) printf("STATIC\n");contador_colunas+=yyleng;             if(flagYacc) {return STATIC;}}
{STRING}                      {if (flagLexx) printf("STRING\n");contador_colunas+=yyleng;             if(flagYacc) {return STRING;}}
{VOID}                        {if (flagLexx) printf("VOID\n");contador_colunas+=yyleng;               if(flagYacc) {return VOID;}}
{WHILE}                       {if (flagLexx) printf("WHILE\n");contador_colunas+=yyleng;              if(flagYacc) {return WHILE;}}
\t|\f|"\ "|\014               {contador_colunas+=yyleng;}

{RESERVED}                    {if (flagLexx) printf("RESERVED(%s)\n",yytext);contador_colunas+=yyleng;}

{ID}                          {if (flagLexx) printf("ID(%s)\n", yytext);contador_colunas+=yyleng;     if(flagYacc) {yylval.id = strdup(yytext); return ID;}}

{INTLIT}                      {if (flagLexx) printf("INTLIT(%s)\n",yytext);contador_colunas+=yyleng;  if(flagYacc) {yylval.id = strdup(yytext); return INTLIT;}}

{REALLIT}                     {if (flagLexx) printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng; if(flagYacc) {yylval.id = strdup(yytext); return REALLIT;}}

.                             {printf("Line %d, col %d: illegal character (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}  

%%

int main(int argc, char *argv[]) {

    if(argc == 2){
        if(!strcmp(argv[1], "-l")){
            flagLexx = 1;
            yylex();
        }else if(!strcmp(argv[1], "-e1")){
            printf("Flag nao existe");
            yylex();
        }else if (!strcmp(argv[1], "-t")){
            mostraTree=1;
            flagYacc=1;
            yyparse();
        //erros do yyac
        }else if(!strcmp(argv[1], "-e2")){
            flagYacc=1;
            yyparse();
        }
    }
    
    if(argc == 3){
        for(int i = 1; i < argc; i++){
            if(!strcmp(argv[i], "-l")){
                flagLexx = 1;  
                yylex();
            } 
            else if(strcmp(argv[i], "-e1") != 0){
                printf("Flag nao existe");
                return 0;
            }
        }
    }
    if(mostraTree && erro == 0){
        printSTree(raiz,0);  
    }else if (mostraTree && erro == 1){
        freeSTree(raiz);
    }
    printf("\n%d | %d\n",mostraTree,erro);
    return 0;
}

int yywrap() {
    return 1;
}

void yyerror (const char *s) {
    switch(strlen(yytext)){
        case 0:
            printf("Line %d, col %d: %s: %s\n", contador_linhas,contador_colunas,s, yytext);
            break;
        default:
            printf("Line %d, col %d: %s: %s\n", contador_linhas,(int)(contador_colunas-yyleng),s, yytext);
            break;
    }
}