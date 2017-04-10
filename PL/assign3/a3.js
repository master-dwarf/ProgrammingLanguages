var fp = require('./fp');
if ( ! exports )
   var exports = [ ];

var util = require('util');

// Sample problem 0.   Reverse from the FP III slides (slides6)

// This just demonstrates how you develop your solutions and add test
// cases

var reverse = function (ns) {
    return reverse_helper(ns,[]);
}

var reverse_helper = function (input,acc) {
    if (fp.isNull(input))
	return acc;
    else
	return reverse_helper(fp.tl(input),fp.cons(fp.hd(input),acc));
}

////////// End of code for problem 0 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 1 must appear between this and matching
// end comment below

var removeLast = function (ns) {
  return removeLast_helper(ns, []);
}

var removeLast_helper = function (ns, l){
  if(fp.isNull(ns))
  return [];
  if(fp.isNull(fp.tl(ns)))
  return l;
  else
  return fp.cons(fp.hd(ns),removeLast_helper(fp.tl(ns),l));
}

////////// End of code for problem 1 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 2 must appear between this and matching
// end comment below

var duple = function(n, x) {
    return duple_helper(n,x,[]);
}

var duple_helper = function(n,x,l) {
  if(fp.isZero(n))
  return l;
  else
  return duple_helper(fp.sub(n,1),x,fp.cons(x,l));
}

////////// End of code for problem 2 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 3 must appear between this and matching
// end comment below

var flatten = function (l) {
    return flatten_helper(l,[]);
}

var flatten_helper = function (l,x){
  if(fp.isNull(l))
  return x;
  if(fp.isList(fp.hd(l)))
  return flatten_helper(fp.hd(l),flatten_helper(fp.tl(l),x));
  else
  return flatten_helper(fp.tl(l),fp.cons(fp.hd(l),x));
}

////////// End of code for problem 3 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 4 must appear between this and matching
// end comment below

var down = function (l) {
    return down_helper(l,[]);
}

var down_helper = function (l,x){
  if(fp.isNull(l))
  return x;
  if(fp.isList(fp.hd(l)))
  return fp.cons(down_helper(fp.hd(l),x),down_helper(fp.tl(l),x));
  else
  return fp.cons([fp.hd(l)],down_helper(fp.tl(l),x));
}

////////// End of code for problem 4 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 5 must appear between this and matching
// end comment below

var up = function (l) {
    return 0;
}


////////// End of code for problem 5 ////////////////////

///////////// ********************** ////////////////////

// Your solution for problem 6 must appear between this and matching
// end comment below

var isMobile = function (bst) {
    return 0;
}

////////// End of code for problem 6 ////////////////////

///////////// ********************** ////////////////////

//// All test cases you add must be below this comment.  Everything
//// below this line will be stripped away to accomodate our more
//// extensive set of test cases when your submission is evaluated

console.log("Testing sample problem 0");
console.log(reverse( [1,2,3] ));
console.log(reverse( [0] ));

console.log("Testing Problem 1");
console.log(removeLast( [1,2,3] ));
console.log(removeLast( [10] ));

console.log("Testing Problem 2");
console.log(duple(6,5));

console.log("Testing Problem 3");
console.log(flatten([1, 2, [3, 4, 5], 6]));

console.log("Testing Problem 4");
console.log(down([1,2,3]));
console.log(down([[1],[2],[4]]));
// For deeply nested lists, util.inspect ensures we see the entire list
console.log(util.inspect(down([1, [2, [3]], 4]), false, null, true));

console.log("Testing Problem 5");
console.log(up ([[1,2],[3,4]]));
console.log(up ([[1, [2]], 3]));


console.log("Testing Problem 6");
var tree1 =     [12, [11, [], [] ],
                     [3, [2, [], [] ],
		         [6, [], [] ]]];
var tree2 =     [12, [11, [], [] ],
                     [3, [4, [], [] ],
		         [4, [], [] ]]];

console.log(isMobile(tree1));
console.log(isMobile(tree2));
