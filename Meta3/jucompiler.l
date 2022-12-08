%{
    /* ===================================================================================
	Compiladores -  Eduardo Figueiredo 2020213717
                 -  Fábio Santos       2020212310
    ====================================================================================== */
    #include "y.tab.h"
    #include "STree.h"
    #include "symtab.h"
    #include <stdio.h>
    #include <string.h>

    int yyparse(void);
    void colocaDados(char * mensagem, int line, int col);
    int contador_linhas = 1;
    int contador_colunas = 1;
    int col = 1;
    int col_string =1;
    int col_comment = 1;
    int line_comment = 1;
    int flagLexx = 0;
    int flagYacc = 0;
    int mostraTree = 0;
    int erroSintax = 0; 
    struct node * raiz;
    struct lista_tabs *lista_tabelas;
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

\"                                         {col_string = col; col += yyleng; BEGIN STRING1;}
<STRING1>{novalinha}                       {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1;col =1; contador_linhas++;BEGIN 0;}
<STRING1>({SCAPES}|[^\r\n\"\\])*\"         {if(flagLexx)printf("STRLIT(\"%s)\n",yytext); contador_colunas+=yyleng;col += yyleng; BEGIN 0; if(flagYacc){colocaDados(strdup(yytext), contador_linhas, col-yyleng);return STRLIT;} }
<STRING1>[^\r\n\"]*\\[^f|n|r|t|\\|\"]*\"   {yyless(0); BEGIN STRINGERROR;}
<STRING1>[^\r\n\"]*{novalinha}?            {yyless(0); BEGIN STRINGERROR;}
<STRING1><<EOF>>                           {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string); col += yyleng; yyterminate();}


<STRINGERROR>\"                            {contador_colunas+=yyleng; col += yyleng; BEGIN 0;} 
<STRINGERROR>{novalinha}                   {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string); contador_colunas=1; col =1; contador_linhas++;BEGIN 0;}   
<STRINGERROR>{SCAPES}                      {contador_colunas+=yyleng; col += yyleng;}
<STRINGERROR>\\[^\n\r\\\"fnrt]             {printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, col ,yytext); contador_colunas+=yyleng; col += yyleng;}
<STRINGERROR>\\                            {printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, col,yytext); contador_colunas+=yyleng; col += yyleng;}
<STRINGERROR><<EOF>>                       {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string); col += yyleng; yyterminate();}
<STRINGERROR>.                             {contador_colunas+=yyleng; col += yyleng;}

\/\*                          {col_comment = col ; line_comment =contador_linhas; contador_colunas+=yyleng ; col += yyleng; BEGIN COMMENT;}
<COMMENT>"*/"                 {contador_colunas+=yyleng; col += yyleng; BEGIN 0;}
<COMMENT>{novalinha}          {contador_colunas=1; col =1; contador_linhas++;}
<COMMENT><<EOF>>              {printf("Line %d, col %d: unterminated comment\n",line_comment, col_comment); col += yyleng; yyterminate();}
<COMMENT>.                    {contador_colunas+=yyleng; col += yyleng;}

"//"                          {contador_colunas++; col += yyleng;BEGIN COMMENT2;}                  
<COMMENT2>{novalinha}         {contador_colunas = 1;col =1;contador_linhas++; BEGIN 0;}
<COMMENT2><<EOF>>             {col += yyleng; yyterminate();}
<COMMENT2>.                   {contador_colunas+=yyleng;col += yyleng;}


{novalinha}                   {contador_colunas=1; col =1; contador_linhas++;}

{BOOLLIT}                     {if (flagLexx) printf("BOOLLIT(%s)\n",yytext);contador_colunas+=yyleng; col += yyleng;if(flagYacc){colocaDados(strdup(yytext), contador_linhas, col-yyleng);return BOOLLIT;}}
{AND}                         {if (flagLexx) printf("AND\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return AND;}}
{ASSIGN}                      {if (flagLexx) printf("ASSIGN\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return ASSIGN;}}
{STAR}                        {if (flagLexx) printf("STAR\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return STAR;}}
{COMMA}                       {if (flagLexx) printf("COMMA\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc) {return COMMA;}}
{DIV}                         {if (flagLexx) printf("DIV\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return DIV;}}
{EQ}                          {if (flagLexx) printf("EQ\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return EQ;}}
{GE}                          {if (flagLexx) printf("GE\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return GE;}}
{GT}                          {if (flagLexx) printf("GT\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return GT;}}
{LBRACE}                      {if (flagLexx) printf("LBRACE\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return LBRACE;}}
{LE}                          {if (flagLexx) printf("LE\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return LE;}}
{LPAR}                        {if (flagLexx) printf("LPAR\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc) {return LPAR;}}
{LSQ}                         {if (flagLexx) printf("LSQ\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc) {return LSQ;}}
{LT}                          {if (flagLexx) printf("LT\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return LT;}}
{MINUS}                       {if (flagLexx) printf("MINUS\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return MINUS;}}
{MOD}                         {if (flagLexx) printf("MOD\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return MOD;}}
{NE}                          {if (flagLexx) printf("NE\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return NE;}}
{NOT}                         {if (flagLexx) printf("NOT\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return NOT;}}
{OR}                          {if (flagLexx) printf("OR\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return OR;}}
{PLUS}                        {if (flagLexx) printf("PLUS\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return PLUS;}}
{RBRACE}                      {if (flagLexx) printf("RBRACE\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return RBRACE;}}
{RPAR}                        {if (flagLexx) printf("RPAR\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc) {return RPAR;}}
{RSQ}                         {if (flagLexx) printf("RSQ\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc) {return RSQ;}}
{SEMICOLON}                   {if (flagLexx) printf("SEMICOLON\n");contador_colunas+=yyleng; col += yyleng;         if(flagYacc) {return SEMICOLON;}}
{ARROW}                       {if (flagLexx) printf("ARROW\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc) {return ARROW;}}   
{LSHIFT}                      {if (flagLexx) printf("LSHIFT\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {colocaDados(NULL, contador_linhas, col-yyleng);return LSHIFT;}}
{RSHIFT}                      {if (flagLexx) printf("RSHIFT\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {colocaDados(NULL, contador_linhas, col-yyleng);return RSHIFT;}}
{XOR}                         {if (flagLexx) printf("XOR\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return XOR;}}
{BOOL}                        {if (flagLexx) printf("BOOL\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc) {return BOOL;}}
{CLASS}                       {if (flagLexx) printf("CLASS\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc) {return CLASS;}}
{DOTLENGTH}                   {if (flagLexx) printf("DOTLENGTH\n");contador_colunas+=yyleng; col += yyleng;         if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return DOTLENGTH;}}
{DOUBLE}                      {if (flagLexx) printf("DOUBLE\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return DOUBLE;}}
{ELSE}                        {if (flagLexx) printf("ELSE\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc) {return ELSE;}}
{IF}                          {if (flagLexx) printf("IF\n");contador_colunas+=yyleng; col += yyleng;                if(flagYacc) {return IF;}}
{INT}                         {if (flagLexx) printf("INT\n");contador_colunas+=yyleng; col += yyleng;               if(flagYacc) {return INT;}}
{PRINT}                       {if (flagLexx) printf("PRINT\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc) {return PRINT;}}
{PARSEINT}                    {if (flagLexx) printf("PARSEINT\n");contador_colunas+=yyleng; col += yyleng;          if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return PARSEINT;}}
{PUBLIC}                      {if (flagLexx) printf("PUBLIC\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return PUBLIC;}}
{RETURN}                      {if (flagLexx) printf("RETURN\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc){colocaDados(NULL, contador_linhas, col-yyleng);return RETURN;}}
{STATIC}                      {if (flagLexx) printf("STATIC\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return STATIC;}}
{STRING}                      {if (flagLexx) printf("STRING\n");contador_colunas+=yyleng; col += yyleng;            if(flagYacc) {return STRING;}}
{VOID}                        {if (flagLexx) printf("VOID\n");contador_colunas+=yyleng; col += yyleng;              if(flagYacc) {return VOID;}}
{WHILE}                       {if (flagLexx) printf("WHILE\n");contador_colunas+=yyleng; col += yyleng;             if(flagYacc) {return WHILE;}}
\t|\f|"\ "|\014               {contador_colunas+=yyleng; col +=yyleng;}

{RESERVED}                    {if (flagLexx) printf("RESERVED(%s)\n",yytext); contador_colunas+=yyleng; col += yyleng;if(flagYacc) {return RESERVED;}}

{ID}                          {if (flagLexx) printf("ID(%s)\n", yytext); contador_colunas+=yyleng;col += yyleng; if(flagYacc){colocaDados(strdup(yytext), contador_linhas, col-yyleng);return ID;}}

{INTLIT}                      {if (flagLexx) printf("INTLIT(%s)\n",yytext); contador_colunas+=yyleng;col += yyleng; if(flagYacc) if(flagYacc){colocaDados(strdup(yytext), contador_linhas, col-yyleng);return INTLIT;}}

{REALLIT}                     {if (flagLexx) printf("REALLIT(%s)\n",yytext); contador_colunas+=yyleng; col += yyleng; if(flagYacc){colocaDados(strdup(yytext), contador_linhas, col-yyleng);return REALLIT;}}

<<EOF>>                       {yyterminate();}

.                             {printf("Line %d, col %d: illegal character (%s)\n", contador_linhas, col,yytext); contador_colunas+=yyleng; col += yyleng;}  

%%

void colocaDados(char * mensagem, int line, int col){
    yylval.info.message = mensagem;
    yylval.info.line=line;
    yylval.info.col=col;
}

int main(int argc, char *argv[]) {

    if(argc == 2){
        if(!strcmp(argv[1], "-l")){
            flagLexx = 1;
            yylex();
        }else if(!strcmp(argv[1], "-e1")){
            yylex();
        }else if (!strcmp(argv[1], "-t")){
            mostraTree=1;
            flagYacc=1;
            yyparse();
            if(raiz != NULL){
                if(erroSintax == 0){
                    printSTree(raiz,0); 
                }else{
                    freeSTree(raiz);
                }
            }
        //erros do yyac
        }else if(!strcmp(argv[1], "-e2")){
            flagYacc=1;
            yyparse();
        }else if(!strcmp(argv[1], "-s")){
            mostraTree=1;
            flagYacc=1;
            yyparse();
            if(raiz != NULL){
                if(erroSintax == 0){
                    lista_tabelas = create_symbol_tab_list(raiz);
                    print_tabs(lista_tabelas);
                    printSTree(raiz,0);
                }else{
                    freeSTree(raiz);
                }
            }
        }
        else if(!strcmp(argv[1], "-e3")){
            mostraTree=1;
            flagYacc=1;
            yyparse();
            if(raiz != NULL){
                if(erroSintax == 0){
                    lista_tabelas = create_symbol_tab_list(raiz);
                }else{
                    freeSTree(raiz);
                }
            }
        }else{
                printf("Flag nao existe");
                return 0;
            }
    }
    
    if(argc == 3){
        for(int i = 1; i < argc; i++){
            if(!strcmp(argv[i], "-l")){
                flagLexx = 1;  
                yylex();
            }else if(!strcmp(argv[i], "-e1") ){
                flagLexx = 0;
            }else if (!strcmp(argv[i], "-t")){
            mostraTree=1;
            flagYacc=1;
            yyparse();
            if(raiz != NULL){
                if(erroSintax == 0){
                    printSTree(raiz,0); 
                }else{
                    freeSTree(raiz);
                }
            }
            //erros do yyac
            }else if(!strcmp(argv[i], "-e2")){
                flagYacc=1;
                yyparse();
            }else if(!strcmp(argv[i], "-s")){
                mostraTree=1;
                flagYacc=1;
                yyparse();
                if(raiz != NULL){
                    if(erroSintax == 0){
                        print_tabs(lista_tabelas);
                        printf("\n");
                        printSTree(raiz,0); 
                    }else{
                        freeSTree(raiz);
                    }
                }
            }else{
                printf("Flag nao existe");
                return 0;
            }
        }
    }
    return 0;
}

int yywrap() {
    return 1;
}

void yyerror (const char *s) {
    if(yytext[strlen(yytext)-1] == '\"'){
        printf("Line %d, col %d: %s: \"%s\n", contador_linhas,(int)(contador_colunas-yyleng),s, yytext);
    }else{
        switch(strlen(yytext)){
            case 0:
                printf("Line %d, col %d: %s: %s\n", contador_linhas,contador_colunas,s, yytext);
                break;
            default:
                printf("Line %d, col %d: %s: %s\n", contador_linhas,(int)(contador_colunas-yyleng),s, yytext);
                break;
        }
    }
}
