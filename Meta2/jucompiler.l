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
    int escape = 1;
    char buf[1000];
    char *s;
    int col_string =1;
    int col_comment = 1;
    int line_comment = 1;
%}

ID               ([a-z]|[A-Z]|"_"|"$")([a-z]|[A-Z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]
sinal                   "-"|"+"
SeqEscInv               "\\"[^("r|"f"|"n"|"t"|\")]
novalinha               (\r?\n)|(\r\n?)
                     
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

%X COMMENT STRING  COMMENT2  
%% 

\"                            { BEGIN STRING; s = buf; escape = 1;col_string = contador_colunas;contador_colunas+=yyleng;}
<STRING>{novalinha}           {*s = 0;BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;}
<STRING>\\\"                  { *s++ = '\\';*s++ = '\"'; contador_colunas+=yyleng;}
<STRING>\\\\                  { *s++ = '\\';*s++ = '\\'; contador_colunas+=yyleng;}
<STRING>\"                    { 
                                *s = 0;
                                BEGIN 0;
                                if ((flag) && (escape)) printf("STRLIT(\"%s\")\n",buf);
                                contador_colunas+=yyleng;
                              }
<STRING>"\\\n"|"\\\r"|"\\\r\n"  {printf("Line %d, col %d: invalid escape sequence (\\)\n", contador_linhas, contador_colunas);*s = 0;
                                    BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);
                                    contador_colunas=1; contador_linhas++;
                                }
<STRING>{SeqEscInv}|\\[\(|\)]   {printf("Line %d, col %d: invalid escape sequence (%s)\n", contador_linhas, contador_colunas,yytext);escape =0;contador_colunas+=yyleng;}      
<STRING><<EOF>>                 {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}
<STRING>.                       { *s++ = *yytext; contador_colunas+=yyleng;}

\/\*                          {col_comment = contador_colunas + yyleng;line_comment =contador_linhas;  BEGIN COMMENT;}
<COMMENT>"*/"                 {contador_colunas = col_comment + yyleng; contador_linhas =  line_comment;  BEGIN 0;}
<COMMENT>{novalinha}          {col_comment=1; line_comment++;}
<COMMENT><<EOF>>              {printf("Line %d, col %d: unterminated comment\n", contador_linhas, contador_colunas);exit(0);}
<COMMENT>.                    {col_comment+=yyleng;}

"//"                          {contador_colunas++; BEGIN COMMENT2;}                  
<COMMENT2>{novalinha}         {contador_colunas = 1;contador_linhas++; BEGIN 0;}
<COMMENT2>.                   {contador_colunas+=yyleng;}

{novalinha}                   {contador_colunas=1; contador_linhas++;}

{BOOLLIT}                     {if (flag) printf("BOOLLIT(%s)\n",yytext);contador_colunas+=yyleng;return BOOLLIT;}
{AND}                         {if (flag) printf("AND\n");contador_colunas+=yyleng;return AND;}
{ASSIGN}                      {if (flag) printf("ASSIGN\n");contador_colunas+=yyleng;return ASSIGN;}
{STAR}                        {if (flag) printf("STAR\n");contador_colunas+=yyleng;return STAR;}
{COMMA}                       {if (flag) printf("COMMA\n");contador_colunas+=yyleng;return COMMA;}
{DIV}                         {if (flag) printf("DIV\n");contador_colunas+=yyleng;return DIV;}
{EQ}                          {if (flag) printf("EQ\n");contador_colunas+=yyleng;return EQ;}
{GE}                          {if (flag) printf("GE\n");contador_colunas+=yyleng;return GE;}
{GT}                          {if (flag) printf("GT\n");contador_colunas+=yyleng;return GT;}
{LBRACE}                      {if (flag) printf("LBRACE\n");contador_colunas+=yyleng;return LBRACE;}
{LE}                          {if (flag) printf("LE\n");contador_colunas+=yyleng;return LE;}
{LPAR}                        {if (flag) printf("LPAR\n");contador_colunas+=yyleng;return LPAR;}
{LSQ}                         {if (flag) printf("LSQ\n");contador_colunas+=yyleng;return LSQ;}
{LT}                          {if (flag) printf("LT\n");contador_colunas+=yyleng;return LT;}
{MINUS}                       {if (flag) printf("MINUS\n");contador_colunas+=yyleng;return MINUS;}
{MOD}                         {if (flag) printf("MOD\n");contador_colunas+=yyleng;return MOD;}
{NE}                          {if (flag) printf("NE\n");contador_colunas+=yyleng;return NE;}
{NOT}                         {if (flag) printf("NOT\n");contador_colunas+=yyleng;return NOT;}
{OR}                          {if (flag) printf("OR\n");contador_colunas+=yyleng;return OR;}
{PLUS}                        {if (flag) printf("PLUS\n");contador_colunas+=yyleng;return PLUS;}
{RBRACE}                      {if (flag) printf("RBRACE\n");contador_colunas+=yyleng;return RBRACE;}
{RPAR}                        {if (flag) printf("RPAR\n");contador_colunas+=yyleng;return RPAR;}
{RSQ}                         {if (flag) printf("RSQ\n");contador_colunas+=yyleng;return RSQ;}
{SEMICOLON}                   {if (flag) printf("SEMICOLON\n");contador_colunas+=yyleng;return SEMICOLON;}
{ARROW}                       {if (flag) printf("ARROW\n");contador_colunas+=yyleng;return ARROW;}
{LSHIFT}                      {if (flag) printf("LSHIFT\n");contador_colunas+=yyleng;return LSHIFT;}
{RSHIFT}                      {if (flag) printf("RSHIFT\n");contador_colunas+=yyleng;return RSHIFT;}
{XOR}                         {if (flag) printf("XOR\n");contador_colunas+=yyleng;return XOR;}
{BOOL}                        {if (flag) printf("BOOL\n");contador_colunas+=yyleng;return BOOL;}
{CLASS}                       {if (flag) printf("CLASS\n");contador_colunas+=yyleng;return CLASS;}
{DOTLENGTH}                   {if (flag) printf("DOTLENGTH\n");contador_colunas+=yyleng;return DOTLENGTH;}
{DOUBLE}                      {if (flag) printf("DOUBLE\n");contador_colunas+=yyleng;return DOUBLE;}
{ELSE}                        {if (flag) printf("ELSE\n");contador_colunas+=yyleng;return ELSE;}
{IF}                          {if (flag) printf("IF\n");contador_colunas+=yyleng;return IF;}
{INT}                         {if (flag) printf("INT\n");contador_colunas+=yyleng;return INT;}
{PRINT}                       {if (flag) printf("PRINT\n");contador_colunas+=yyleng;return PRINT;}
{PARSEINT}                    {if (flag) printf("PARSEINT\n");contador_colunas+=yyleng;return PARSEINT;}
{PUBLIC}                      {if (flag) printf("PUBLIC\n");contador_colunas+=yyleng;return PUBLIC;}
{RETURN}                      {if (flag) printf("RETURN\n");contador_colunas+=yyleng;return RETURN;}
{STATIC}                      {if (flag) printf("STATIC\n");contador_colunas+=yyleng;return STATIC;}
{STRING}                      {if (flag) printf("STRING\n");contador_colunas+=yyleng;return STRING;}
{VOID}                        {if (flag) printf("VOID\n");contador_colunas+=yyleng;return VOID;}
{WHILE}                       {if (flag) printf("WHILE\n");contador_colunas+=yyleng;return WHILE;}
\t|\f|"\ "|\014               {contador_colunas+=yyleng;}

{RESERVED}                    {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;return RESERVED;}

{ID}                   {if (flag) printf("ID(%s)\n", yytext);contador_colunas+=yyleng;return ID;}

{INTLIT}                      {if (flag) printf("INTLIT(%s)\n",yytext);contador_colunas+=yyleng;return INTLIT;}

{REALLIT}                     {if (flag) printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng;return REALLIT;}

.                             {printf("Line %d, col %d: illegal character (%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}  

%%

int yywrap() {
    return 1;
}