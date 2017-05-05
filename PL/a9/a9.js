// Note -- the next two lines should ensure that the is module is uncached.
var name = require.resolve('./is');
delete require.cache[name];

var is = require("./is");

if ( ! exports )
   var exports = [ ];

// Construct two sequences used in testing

var primes = function () {
    var sift = function (p,s) { return is.filter(function (n) { return n % p !== 0; }, s); };
    var helper = function (s) {
	return is.cons(is.hd(s), function () { return helper(sift(is.hd(s), is.tl(s))); } );
    };
    return helper(is.from(2));
}();

var evens = is.filter(function (n) { return (n % 2 === 0); }, is.from(1));

// Problem 1 //////////////////////////


/////// Problem 1 //////////////////////

var hailstone = function (n) {
  return is.cons(n, function(){return (n%2==0 ? (hailstone(n/2)) : (hailstone(3*n+1)))})
};


/////// Problem 2 /////////////////

var merge = function (s1, s2) {

    /* to be completed */

};

////// Problem 3 /////////////////

//// Note that strange_sequence is the result of calling on an
//// anonymous function that, when called, produces the desired
//// sequence -- similar to the way that we bound the sequence of all
//// prime numbers to the variable primes in the class notes

var strange_sequence = function () {

    /* to be completed */

}();


//////////////////////////////////////////////////

//// All test cases you add must be below this comment.  Everything
//// below this line will be stripped away to accomodate our more
//// extensive set of test cases when your submission is evaluated

console.log("Hailstone");
console.log(is.take(hailstone(5), 10));
console.log(is.take(hailstone(11), 20));

console.log("Merge");
console.log(is.take(merge(evens, primes), 20));

console.log("Strange Sequence");
console.log(is.take(strange_sequence, 30));
