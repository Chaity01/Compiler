%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
void yyerror(const char *s){
fprintf(stderr,"%s\n",s);
}
extern FILE *yyin;
int start = 0, end = 0, count=0,average=0;
bool loop_variable[28];
int yylex();
%}

%token SUM AVERAGE_SUM NUMBER 
%%
series_expression : series_expression sum_exp {}
                  | sum_exp {}
                  ;
sum_exp : summation_expression {}
        | average_summation_expression {}
        
        ;

summation_expression : SUM '(' Statement ',' Statement ')' ';' {
                         printf ( "Summation = %d\n", $3 + $5 );
                     }
                     ;

average_summation_expression : AVERAGE_SUM '(' Statement ',' Statement ')' ';' {
                                int sum = 0;
                                for ( int i = $3; i <= $5; ++i ){
                                if(i>0){                                
                                sum += i;
                                count++;
                                }
                                }
                                
                                if(count==0){
                                printf("No positive numbers found in the specified range\n");
                                }
                                else{
                                average = sum/count;
                                printf("Average of the positive number of the range is :%d \n",average);
                                }
                                
                                };
                                  

Statement : Statement '+' Term { $$ = $1 + $3; }
          | Statement '-' Term { $$ = $1 - $3; }
          | Term { $$ = $1; }
          ;
Term : Term '*' Factor { $$ = $1 * $3; }
     | Term '/' Factor { $$ = $1 / $3; }
     | Factor { $$ = $1; }
     ;
Factor : NUMBER { $$ = $1; }
       | '(' Statement ')' { $$ = $2; }
       ;

%%
int main(){
FILE *file;
file = fopen("code.c", "r") ;
if (!file) {
printf("couldnot open file");
exit (1);
}
else {
yyin = file;
}
yyparse();
}
