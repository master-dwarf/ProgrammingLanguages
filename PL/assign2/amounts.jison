/*
    description: Parses check amounts
*/

// lexical section of the grammar
// ==============================

// ******* you are NOT allowed to modify the lexical section ************

%lex
%%
\s+                   /* no return statement, so skip whitespace */
[0]		      return "ZERO"
[1-9]		      return "POSITIVE_DIGIT"
"*"                   return "ASTERISK"
"$"                   return "DOLLAR"
","                   return "COMMA"
"."                   return "POINT"
<<EOF>>               return "EOF"
.                     return "INVALID"

/lex

%start program

// phrase-structure section of the grammar
// =======================================

%%

program
    : amount EOF
    ;


// ********* this is where you must write your grammar ****************

amount
    :"DOLLAR" stars money cents
    ;

stars
    : /*EMPTY*/
    | "ASTERISK" stars
    ;

money
    : "ZERO"
    | "POSITIVE_DIGIT" more_money
    | "POSITIVE_DIGIT" "ZERO" more_money
    | "POSITIVE_DIGIT" "POSITIVE_DIGIT" more_money
    | "POSITIVE_DIGIT" "ZERO" "POSITIVE_DIGIT" more_money
    | "POSITIVE_DIGIT" "POSITIVE_DIGIT" "ZERO" more_money
    | "POSITIVE_DIGIT" "POSITIVE_DIGIT" "POSITIVE_DIGIT" more_money
    ;
more_money
    : /*EMPTY*/
    | "COMMA" "ZERO" "ZERO" "ZERO" more_money
    | "COMMA" "POSITIVE_DIGIT" "ZERO" "ZERO" more_money
    | "COMMA" "ZERO" "POSITIVE_DIGIT" "ZERO" more_money
    | "COMMA" "ZERO" "ZERO" "POSITIVE_DIGIT" more_money
    | "COMMA" "POSITIVE_DIGIT" "POSITIVE_DIGIT" "ZERO" more_money
    | "COMMA" "POSITIVE_DIGIT" "ZERO" "POSITIVE_DIGIT" more_money
    | "COMMA" "ZERO" "POSITIVE_DIGIT" "POSITIVE_DIGIT" more_money
    | "COMMA" POSITIVE_DIGIT POSITIVE_DIGIT POSITIVE_DIGIT more_money
    ;
cents
    : /*EMPTY*/
    | "POINT" "ZERO" "ZERO"
    | "POINT" "ZERO" "POSITIVE_DIGIT"
    | "POINT" "POSITIVE_DIGIT" "ZERO"
    | "POINT" "POSITIVE_DIGIT" "POSITIVE_DIGIT"
    ;

%%
