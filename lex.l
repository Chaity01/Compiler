%{
#include "y.tab.h"
extern int yylval;
%}
%%
"sum" { return SUM; }
"average_sum" { return AVERAGE_SUM; }

[0-9]+ { yylval = atoi ( yytext ); return NUMBER; }
[ \t]+ {} /* ignore whitespace */

#(include)\<[a-z]+[a-z]\.(h)\> {printf("Valid C header file. \n");}

("int main"\(\)\{|"void main"\(\)\{|"double main"\(\)\{) {printf("Valid Main Function \n");}

("int start="[0-9]+\;) {printf("Valid statement \n");}
("int end="[0-9]+\;) {printf("Valid statement \n");}
("int count="[0-9]+\;) {printf("Valid statement \n");}
("int average="[0-9]+\;) {printf("Valid statement \n");}
("for\(int i=start;i<=end;i++\)") {printf("valid for loop \n");}

("if"\([i]\>0\)) {printf("Valid if statement \n");}
("sum+=var\;") {printf("Valid inner if statement \n");}
("count++\;") {printf("Valid count statement \n");}


("if\(count==0\)") {printf("Valid if condition \n");}
("printf\(\"No positive numbers found in the specified range\.\\n\"\)\;") {printf("Valid print statement \n");}
("else") {printf("Valid else condition \n");}
("int average=sum\/count\;") {printf("Valid to calculate average \n");}
("printf\(\"Average of positive numbers in the range is\:\%d\\n\"\,average\)\;") {printf("Valid print statement \n");}
\} {printf("End of the main function \n");}

. { return yytext[0]; }
%%


