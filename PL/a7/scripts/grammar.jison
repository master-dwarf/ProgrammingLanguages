/* description: Grammar for SLang 1 */

/* lexical grammar */
%lex

DIGIT		      [0-9]
LETTER		      [a-zA-Z]

%%

\s+                                   { /* skip whitespace */ }
"fn"				      { return 'FN'; }
"("                   		      { return 'LPAREN'; }
")"                   		      { return 'RPAREN'; }
"+"                   		      { return 'PLUS'; }
"*"                   		      { return 'TIMES'; }
"%"                             { return 'MOD';}
"/"                             { return 'DIVIDE';}
"-"                             { return 'SUB';}
"~"                             { return 'NEG';}
"=="                            { return 'EQL'; }
"!"                             { return 'NOT'; }
">"                             { return 'GT'; }
"<"                             { return 'LT'; }
"?"                             { return 'COND'; }
"["                             { return 'LBRACK'; }
"]"                             { return 'RBRACK'; }
"add1"                                { return 'ADD1'; }
","                   		      { return 'COMMA'; }
"=>"                   		      { return 'THATRETURNS'; }
<<EOF>>               		      { return 'EOF'; }
{LETTER}({LETTER}|{DIGIT}|_)*  	      { return 'VAR'; }
{DIGIT}+                              { return 'INT'; }
.                     		      { return 'INVALID'; }

/lex

%start program

%% /* language grammar */

program
    : exp EOF
        { return SLang.absyn.createProgram($1); }
    ;

exp
    : var_exp       { $$ = $1; }
    | intlit_exp    { $$ = $1; }
    | fn_exp        { $$ = $1; }
    | app_exp       { $$ = $1; }
    | prim_app_exp  { $$ = $1; }
    | cond_exp      { $$ = $1; }
    | list_exp      { $$ = $1; }
    ;

var_exp
    : VAR  { $$ = SLang.absyn.createVarExp( $1 ); }
    ;

intlit_exp
    : INT  { $$ =SLang.absyn.createIntExp( $1 ); }
    ;

fn_exp
    : FN LPAREN formals RPAREN THATRETURNS exp
           { $$ = SLang.absyn.createFnExp($3,$6); }
    ;

cond_exp
    : COND LPAREN exp COMMA exp COMMA exp RPAREN
          { $$ = SLang.absyn.createCondExp($3,$5,$7); }
    ;

list_exp
    : LBRACK int_list RBRACK
        { $$ = SLang.absyn.createList($2);}
    ;

int_list
    : /* empty */ {$$ = [];}
    | INT int_list { $2.unshift($1); $$ = $2; }
    | COMMA int_list { $$ = $2;}
    ;

formals
    : /* empty */ { $$ = [ ]; }
    | VAR moreformals
        { var result;
          if ($2 === [ ])
	     result = [ $1 ];
          else {
             $2.unshift($1);
             result = $2;
          }
          $$ = result;
        }
    ;

moreformals
    : /* empty */ { $$ = [ ] }
    | COMMA VAR moreformals
       { $3.unshift($2);
         $$ = $3; }
    ;

app_exp
    : LPAREN exp args RPAREN
       {  $3.unshift("args");
          $$ = SLang.absyn.createAppExp($2,$3); }
    ;

prim_app_exp
    : prim_op LPAREN prim_args RPAREN
       { $$ = SLang.absyn.createPrimAppExp($1,$3); }
    ;

prim_op
    :  PLUS     { $$ = $1; }
    |  TIMES    { $$ = $1; }
    |  ADD1     { $$ = $1; }
    |  MOD      { $$ = $1; }
    |  DIVIDE   { $$ = $1; }
    |  SUB      { $$ = $1; }
    |  NEG      { $$ = $1; }
    |  EQL      { $$ = $1; }
    |  NOT      { $$ = $1; }
    |  LT       { $$ = $1; }
    |  GT       { $$ = $1; }
    ;

args
    : /* empty */ { $$ = [ ]; }
    | exp args
        { var result;
          if ($2 === [ ])
	     result = [ $1 ];
          else {
             $2.unshift($1);
             result = $2;
          }
          $$ = result;
        }
    ;

prim_args
    :  /* empty */ { $$ = [ ]; }
    |  exp more_prim_args    { $2.unshift($1); $$ = $2; }
    ;

more_prim_args
    : /* empty */ { $$ = [ ] }
    | COMMA exp more_prim_args { $3.unshift($2); $$ = $3; }
    ;



%%
