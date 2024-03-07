/* CS 155 Lab Exercise 1 */
/* le1-202011654.flex */
/* V1 29-Feb-2024 */

%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
int lineno = 1;
void ret_print(char *token_type);
void yyerror();
%}

DIGIT          [0-9]
CHARSTRING     [a-zA-Z0-9 ]
CHAR           [a-zA-Z]
ID             [0-9a-zA-Z]*


%%
"PROCEDURE"|"VAR"|"STRING"|"WRITELN"|"NOT"|"OR"|"DIV"|"MOD"|"AND"|"IF"|"THEN"|"ELSE"|"WHILE"|"DO"|"FOR"|"TO"|"DOWNTO"|":="|"BEGIN"|"END"  { ret_print("RESERVED_WORD"); }
"INTEGER"|"REAL"|"BOOLEAN"|"STRING" { ret_print("TYPE"); }
{DIGIT}	{ ret_print("DIGIT"); }
{DIGIT}+ 	{ ret_print("IntNumber"); }
{DIGIT}+"."{DIGIT}* { ret_print("RealNumber");}
{DIGIT}+ { ret_print("UnsignedDigitSeq");}
"+"{DIGIT}+|"-"{DIGIT}+ { ret_print("DigitSeq");}
"True"|"False" 	{ ret_print("BOOLEAN");}
"\""{CHARSTRING}+"\"" 	{ ret_print("STRING");}
{CHAR}+  { ret_print("StringChar");}
{CHAR} 	{ ret_print("LETTER");}
"+"|"-" 	{ ret_print("Sign"); }
"*"|"/" 	{ ret_print("MulOp"); }
"="|"<>"|"<"|"<="|">"|">=" 	{ ret_print("RelOp"); }
"," 	{ ret_print("Comma"); }
";" 	{ ret_print("Semicolon"); }
":"	{ ret_print("Colon"); }
"("	{ ret_print("OpenPar"); }
")"	{ ret_print("ClosePar"); }
"{"	{ ret_print("OpenBr"); }
"}"	{ ret_print("CloseBr"); }
"\""	{ ret_print("QuotationMark"); }
{CHAR}{ID} { ret_print("Ident"); }
"\n"         { lineno++;}
[ \t\r\f]+	 /* eat up whitespace */
.	           { yyerror("");}
%%

void ret_print(char *token_type){
   printf("L%d: [%s, \"%s\"]\n", lineno, token_type, yytext);
}

void yyerror(char *message){
   printf("L%d: lexical error %s\n", lineno, yytext);
   exit(1);
}

int main(int argc, char *argv[]){
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
   return 0;
}
