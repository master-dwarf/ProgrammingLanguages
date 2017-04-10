// LC.interpret will invoke the lambda-calculus interpreter
// on a string containing a lambda-calclus expression
var LC = require("./lambdacalculus.js");

////// Next we define some Church encodings you can use in the assignment

// Logical values
var T = "^x y.x";
var F = "^x y.y";
var AND = "^a b.((a b) "+F+")";
var IF = "^p x y.((p x) y)";
var OR = "^p q.((("+IF+" p) "+T+") q)";


// Integer values

var ZERO = "^f x.x";
var ONE = "^f x.(f x)";
var TWO = "^f x.(f (f x))";
var THREE = "^f x.(f (f (f x)))";
var FOUR = "^f x.(f (f (f (f x))))";
var FIVE = "^f x.(f (f (f (f (f x)))))";
var SIX = "^f x.(f (f (f (f (f (f x))))))";
var SEVEN = "^f x.(f (f (f (f (f (f (f x)))))))";
var EIGHT = "^f x.(f (f (f (f (f (f (f (f x))))))))";
var NINE = "^f x.(f (f (f (f (f (f (f (f (f x)))))))))";
var ADD = "^n m f x.((n f) ((m f) x))";
var MULT = "^n m f x.((n (m f)) x)";

// Successor, predecessor, and IsZero
var SUCC = "^n f x.(f ((n f) x))";
var ISZERO = "^n.((n ^x."+F+") "+T+")";
var PRED = "^n.^f.^x.(((n ^g.^h.(h (g f))) ^u.x) ^u.u)";


// And of course, the Y combinator!
var Y = "^h.(^x.(h (x x)) ^x.(h (x x)))";

// Problem 0 -- just a demo of how to use the encodings and Y to define factorial
var FACT = "^f x.((("+IF+" ("+ISZERO+" x)) "+ONE+") (("+MULT+" x) (f ("+PRED+" x))))";
var Y_FACT = "("+Y+" "+FACT+")";

//////////// End of provided Church encodings //////////////////////////////////

// Problem 1
var SUBREC = "^f x y.((("+IF+" ("+ISZERO+" y)) x) ((f ("+PRED+" x)) ("+PRED+" y)))";
// Uncomment the next line after you have defined SUBREC
var Y_SUB = "("+Y+" "+SUBREC+")";

// Problem 2
var LE = "^f x y.((("+IF+" ("+ISZERO+" x)) "+T+") ((("+IF+" ("+ISZERO+" y)) "+F+") ((f ("+PRED+" x)) ("+PRED+" y))))";
// Uncomment the next line after you have defined LE
var Y_LE = "("+Y+" "+LE+")";

// Problem 3
var LT = "^f x y.((("+IF+" ("+ISZERO+" y)) "+F+") ((("+IF+" ("+ISZERO+" x)) "+T+") ((f ("+PRED+" x)) ("+PRED+" y))))"
var Y_LT = "("+Y+" "+LT+")";
var QUOTIENT = "^f x y.((("+IF+" (("+Y_LT+" x) y)) "+ZERO+") ("+SUCC+" ((f (("+Y_SUB+" x) y)) y)))";
// Uncomment the next line after you have defined EXPREC
var Y_QUO = "("+Y+" "+QUOTIENT+")";


// Problem 4
var EXPREC = "^f x y.((("+IF+" ("+ISZERO+" y)) "+ONE+") (("+MULT+" x) ((f x) ("+PRED+" y))))";
// Uncomment the next line after you have defined EXPREC
var Y_EXP = "("+Y+" "+EXPREC+")";

// Problem 5
// Matt Might's JS implementation of Y
var Y_in_JS = function (h) {
    return (function (x) {
	return h(function (y) { return (x(x))(y);});
    })
    (function (x) {
	return h(function (y) { return (x(x))(y);});
    }) ;
} ;

// The example discussed in class notes
var FactGen = function (fact) {
    return (function(n) {
	return ((n == 0) ? 1 : (n*fact(n-1))) ;
    });
} ;


var GCD_gen = function(fact){
  return function(x){
    return function(y){
      return (x%y == 0) ? y : (y == 0) ? x : (fact(y)(x%y));
    }
  }
};

///////////////////////////////////////////////////////////////////
//// All test cases you add must be below this comment.  Everything
//// below this line will be stripped away to accomodate our more
//// extensive set of test cases when your submission is evaluated

// Testing Problem 0
console.log("Factorial of 3 " + LC.interpret("("+Y_FACT+ " " +THREE+")"));

//Testing Problem 1
console.log("Subtract 3 from 5: " + LC.interpret("(("+Y_SUB+" "+FIVE+") "+THREE+")"));

//Testing Problem 2
console.log("5 <= 3 " + LC.interpret("(("+Y_LE+" "+FIVE+") "+THREE+")"));
console.log("3 <= 5 " + LC.interpret("(("+Y_LE+" "+THREE+") "+FIVE+")"));

// Testing Problem 3
console.log("Div 2 by 3 " + LC.interpret("(("+Y_QUO+" "+TWO+") "+THREE+")"));
console.log("Div 3 by 2 " + LC.interpret("(("+Y_QUO+" "+THREE+") "+TWO+")"));
console.log("Div 2 by 4 " + LC.interpret("(("+Y_QUO+" "+TWO+") "+FOUR+")"));
console.log("Div 4 by 2 " + LC.interpret("(("+Y_QUO+" "+FOUR+") "+TWO+")"));
console.log("Div 5 by 3 " + LC.interpret("(("+Y_QUO+" "+FIVE+") "+THREE+")"));
console.log("Div 3 by 5 " + LC.interpret("(("+Y_QUO+" "+THREE+") "+FIVE+")"));
console.log("Div 4 by 1 " + LC.interpret("(("+Y_QUO+" "+FOUR+") "+ONE+")"));
console.log("Div 1 by 4 " + LC.interpret("(("+Y_QUO+" "+ONE+") "+FOUR+")"));

//Testing Problem 4
console.log("2 raised to the 3rd power " + LC.interpret("(("+Y_EXP+" "+TWO+") "+THREE+")"));

//Testing Problem 5
console.log("Using Might's Y to define factorial and invoking it on 6 yields" + (Y_in_JS(FactGen))(6));
console.log("GCD 21 and 7 is " + ((Y_in_JS(GCD_gen))(21))(7)) ;
console.log("GCD 32 and 7 is " + ((Y_in_JS(GCD_gen))(23))(7)) ;
