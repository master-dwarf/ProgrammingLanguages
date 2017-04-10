/*
    description: Parses and interprets boolean expressions
*/

// lexical section of the grammar
// ==============================

// ******* you are NOT allowed to modify the lexical section ************
%lex
%%
\s+                   /* no return statement, so skip whitespace */
[1-9][0-9]*	      return "INT"
"true"                return "TRUE"
"false"               return "FALSE"
"("                   return "LPAREN"
")"                   return "RPAREN"
"&&"                  return "AND"
"||"                  return "OR"
"!|"                  return "NOR"
"!&"                  return "NAND"
"!"                   return "NOT"
"@"                   return "XOR"
<<EOF>>               return "EOF"
.                     return "INVALID"

/lex

%start program

// phrase-structure section of the grammar
// =======================================

%%

program
    : e1 EOF   { return $1; }
    ;

// ********* this is where you must write your grammar/interpreter ****************

e1
    : xor
    {$$ = $1;}
    ;
xor
    : or_nor
    {$$ = $1;}
    | xor "XOR" or_nor
    {$$ = ($1 && !$3) || (!$1 && $3)}
    ;
or_nor
    : and_nand
    {$$ = $1;}
    | or_nor "OR" and_nand
    {$$ = $1 || $3;}
    | or_nor "NOR" and_nand
    {$$ = !($1 || $3);}
    ;
and_nand
    : not
    {$$ = $1;}
    | and_nand "AND" not
    {$$ = $1 && $3;}
    | and_nand "NAND" not
    {$$ = !($1 && $3);}
    ;
not
    : group
    {$$ = $1;}
    | "NOT" not
    {$$ = ! $2;}
    ;
group
    : boolean
    {$$ = $1;}
    | "LPAREN" e1 "RPAREN"
    {$$ = $2;}
    ;

boolean
    :"TRUE"
    {$$ = true;}
    |"FALSE"
    {$$ = false;}
    ;




%%
