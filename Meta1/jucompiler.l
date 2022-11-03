%{
    /* ===================================================================================
	Compiladores -  Eduardo Figueiredo 2020213717
                    Fabio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include <string.h>
    
    int contador_linhas = 1;
    int contador_colunas = 1;
    int flag = 0;
    int col_string =1;
    int col_comment = 1;
    int line_comment = 1;
%}

ID                      ([a-z]|[A-Z]|"_"|"$")([a-z]|[A-Z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]
sinal                   "-"|"+"
SeqEscInv               "\\"[^rfnt\\\"]
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

STRLIT                  ({SCAPES}|[^\r\n\"\\])*


%X COMMENT STRING1 STRINGERROR COMMENT2  
%% 

\"                               {BEGIN STRING1;  col_string = contador_colunas;contador_colunas+=yyleng;}
<STRING1>{novalinha}             {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;BEGIN 0;}
<STRING1>{STRLIT}\"              {if (flag) printf("STRLIT(\"%s)\n",yytext); contador_colunas+=yyleng; BEGIN 0;}      
<STRING1>"\\\n"|"\\\r"|"\\\r\n"  {printf("Line %d, col %d: invalid escape sequence (\\)\n", contador_linhas, contador_colunas);
                                    BEGIN 0; {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);}
                                    contador_colunas=1; contador_linhas++;
                                 }
<STRING1>{SeqEscInv}|\\[\(|\)]   {printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;BEGIN STRINGERROR;}      
<STRING1><<EOF>>                 {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}
<STRING1>{SCAPES}                { contador_colunas+=yyleng;BEGIN STRINGERROR;}
<STRING1>.                       { contador_colunas+=yyleng;BEGIN STRINGERROR;}


<STRINGERROR>"\\\n"|"\\\r"|"\\\r\n"  {printf("Line %d, col %d: invalid escape sequence (\\)\n", contador_linhas, contador_colunas);
                                    BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);
                                    contador_colunas=1; contador_linhas++;
                                    } 
<STRINGERROR>{novalinha}            {BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;}
<STRINGERROR>{SeqEscInv}|\\[\(|\)]  {printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}      
<STRINGERROR><<EOF>>                {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}
<STRINGERROR>\"                     {  BEGIN 0; contador_colunas+=yyleng;} 
<STRINGERROR>{SCAPES}               { contador_colunas+=yyleng;}
<STRINGERROR>.                      { contador_colunas+=yyleng;}
    
\/\*                          {col_comment = contador_colunas + yyleng;line_comment =contador_linhas;  BEGIN COMMENT;}
<COMMENT>"*/"                 {contador_colunas = col_comment + yyleng; contador_linhas =  line_comment;  BEGIN 0;}
<COMMENT>{novalinha}          {col_comment=1; line_comment++;}
<COMMENT><<EOF>>              {printf("Line %d, col %d: unterminated comment\n", contador_linhas, contador_colunas);exit(0);}
<COMMENT>.                    {col_comment+=yyleng;}

"//"                          {contador_colunas++; BEGIN COMMENT2;}                  
<COMMENT2>{novalinha}         {contador_colunas = 1;contador_linhas++; BEGIN 0;}
<COMMENT2>.                   {contador_colunas+=yyleng;}

{novalinha}                   {contador_colunas=1; contador_linhas++;}

{BOOLLIT}                     {if (flag) printf("BOOLLIT(%s)\n",yytext);contador_colunas+=yyleng;}
{AND}                         {if (flag) printf("AND\n");contador_colunas+=yyleng;}
{ASSIGN}                      {if (flag) printf("ASSIGN\n");contador_colunas+=yyleng;}
{STAR}                        {if (flag) printf("STAR\n");contador_colunas+=yyleng;}
{COMMA}                       {if (flag) printf("COMMA\n");contador_colunas+=yyleng;}
{DIV}                         {if (flag) printf("DIV\n");contador_colunas+=yyleng;}
{EQ}                          {if (flag) printf("EQ\n");contador_colunas+=yyleng;}
{GE}                          {if (flag) printf("GE\n");contador_colunas+=yyleng;}
{GT}                          {if (flag) printf("GT\n");contador_colunas+=yyleng;}
{LBRACE}                      {if (flag) printf("LBRACE\n");contador_colunas+=yyleng;}
{LE}                          {if (flag) printf("LE\n");contador_colunas+=yyleng;}
{LPAR}                        {if (flag) printf("LPAR\n");contador_colunas+=yyleng;}
{LSQ}                         {if (flag) printf("LSQ\n");contador_colunas+=yyleng;}
{LT}                          {if (flag) printf("LT\n");contador_colunas+=yyleng;}
{MINUS}                       {if (flag) printf("MINUS\n");contador_colunas+=yyleng;}
{MOD}                         {if (flag) printf("MOD\n");contador_colunas+=yyleng;}
{NE}                          {if (flag) printf("NE\n");contador_colunas+=yyleng;}
{NOT}                         {if (flag) printf("NOT\n");contador_colunas+=yyleng;}
{OR}                          {if (flag) printf("OR\n");contador_colunas+=yyleng;}
{PLUS}                        {if (flag) printf("PLUS\n");contador_colunas+=yyleng;}
{RBRACE}                      {if (flag) printf("RBRACE\n");contador_colunas+=yyleng;}
{RPAR}                        {if (flag) printf("RPAR\n");contador_colunas+=yyleng;}
{RSQ}                         {if (flag) printf("RSQ\n");contador_colunas+=yyleng;}
{SEMICOLON}                   {if (flag) printf("SEMICOLON\n");contador_colunas+=yyleng;}
{ARROW}                       {if (flag) printf("ARROW\n");contador_colunas+=yyleng;}
{LSHIFT}                      {if (flag) printf("LSHIFT\n");contador_colunas+=yyleng;}
{RSHIFT}                      {if (flag) printf("RSHIFT\n");contador_colunas+=yyleng;}
{XOR}                         {if (flag) printf("XOR\n");contador_colunas+=yyleng;}
{BOOL}                        {if (flag) printf("BOOL\n");contador_colunas+=yyleng;}
{CLASS}                       {if (flag) printf("CLASS\n");contador_colunas+=yyleng;}
{DOTLENGTH}                   {if (flag) printf("DOTLENGTH\n");contador_colunas+=yyleng;}
{DOUBLE}                      {if (flag) printf("DOUBLE\n");contador_colunas+=yyleng;}
{ELSE}                        {if (flag) printf("ELSE\n");contador_colunas+=yyleng;}
{IF}                          {if (flag) printf("IF\n");contador_colunas+=yyleng;}
{INT}                         {if (flag) printf("INT\n");contador_colunas+=yyleng;}
{PRINT}                       {if (flag) printf("PRINT\n");contador_colunas+=yyleng;}
{PARSEINT}                    {if (flag) printf("PARSEINT\n");contador_colunas+=yyleng;}
{PUBLIC}                      {if (flag) printf("PUBLIC\n");contador_colunas+=yyleng;}
{RETURN}                      {if (flag) printf("RETURN\n");contador_colunas+=yyleng;}
{STATIC}                      {if (flag) printf("STATIC\n");contador_colunas+=yyleng;}
{STRING}                      {if (flag) printf("STRING\n");contador_colunas+=yyleng;}
{VOID}                        {if (flag) printf("VOID\n");contador_colunas+=yyleng;}
{WHILE}                       {if (flag) printf("WHILE\n");contador_colunas+=yyleng;}

{RESERVED}                    {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;}

{ID}                          {if (flag) printf("ID(%s)\n", yytext);contador_colunas+=yyleng;}

{INTLIT}                      {if (flag) printf("INTLIT(%s)\n",yytext);contador_colunas+=yyleng;}

{REALLIT}                     {if (flag) printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng;}

\t|\f|"\ "|\014               {contador_colunas+=yyleng;}
.                             {printf("Line %d, col %d: illegal character (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}  

%%

int main(int argc, char *argv[]) {

    if(argc == 2){
        if(!strcmp(argv[1], "-l")){
            flag = 1;
        }else if(strcmp(argv[1], "-e1")!=0){
                printf("Flag nao existe");
                return 0;
        } 
    }
    
    if(argc == 3){
        for(int i = 1;i<argc;i++){
            if(!strcmp(argv[i], "-l")) flag = 1;
            else if(strcmp(argv[i], "-e1")!=0){
                printf("Flag nao existe");
                return 0;
            }
        }
    }

    yylex();
    return 0;
}

int yywrap() {
    return 1;
}