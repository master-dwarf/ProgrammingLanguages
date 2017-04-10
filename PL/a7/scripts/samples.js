/* global SLang : true */

(function () {

"use strict";

    // 2 //"Boolean ops", "(1 === ( (100 / 4) % 3))",

    // 3 "not( ((11 / 4) > (30 - (25 % 13))) )

    // 4 if n then (p + q) else (p * q) (6 < 1) 2 3)"

    // 5 if n then (p + q) else (p * q) (6 > 1) 2 3)",

    // 6 if n then (p + q) else (q / 0) 1 2 3)",

    // 7 if n then (p + q) else (q / 0) 1 2 3)"
    
var samples = [

/* 0 */   "",
/* 1 */   [ "New prim. arithmetic operators",
	    "(fn (n,p,q) => /(-(+(~(n), 20), p) , %(q, 3)) 10 2 11)",
            '["Num",4]' ],
/* 2 */   [ "Boolean ops", "==(1, %(/(100 , 4) , 3) )",
	    '["Bool",true]' ],
/* 3 */   [ "Boolean ops", "!( >(/(11, 4), -(30, %(25, 13))) )",
	    '["Bool",true]'],
/* 4 */   [ "Cond exp" , 
	    "(fn (n,p,q) => ?(n, +(p, q), *(p, q)) <(6, 1) 2 3)",
	    '["Num",6]' ],
/* 5 */   [ "Cond exp" , 
	    "(fn (n,p,q) => ?(n, +(p, q), *(p, q)) >(6, 1) 2 3)",
            '["Num",5]' ],
/* 6 */   [ "Cond exp" , 
	    "(fn (n,p,q) => ?(n, +(p, q), /(q, 0)) 1 2 3)",
            'No output [Runtime error]' ],
/* 7 */   [ "Cond expression" , 
	    "(fn (n,p,q) => ?(n, +(p, q), /(q, 0)) >(6, 1) 2 3)",
            '["Num",5]' ],
/* 8 */   [ "Lists", "[]", '["List",[]]' ],
/* 9 */   [ "Lists", "[1]", '["List",[1]]' ],
/* 10 */  [ "Lists", "[1,2,3,4,5]", '["List",[1,2,3,4,5]]' ],
/* 11 */  [ "Lists", "( fn (x) => sumlist(x) [1,2,3] )", '["Num",6]' ],
/* 12 */  [ "map", "map(fn(x) => add1(x), [ ])", '["List",[]]' ],
/* 13 */  [ "map", "map(fn(x) => x, [1,2,3,5,6])", '["List",[1,2,3,5,6]]' ],
/* 14 */  [ "map", "map(fn(x) => *(2, x),  [1,2,3,5,6])", 
	    '["List",[2,4,6,10,12]]' ],
/* 15 */  [ "map", "map(fn(x) => *(x, x), [1,2,3])", 
	    '["List",[1,4,9]]' ],
/* 16 */  [ "map", "map((fn(x) => fn (y) => +(x, y) 10), [1,2,3,5,6])", 
	    '["List",[11,12,13,15,16]]' ],
/* 17 */  [ "map", "(fn (f,list) => map(f, list) x [1,2,3])", 
	    'No output [Runtime error]' ],
/* 18 */  [ "map", "map(fn(x) => x, 1)", 
	    'No output [Runtime error]' ]
];

 window.SLang.samples = samples;
    console.log("done loading samples");
})();
