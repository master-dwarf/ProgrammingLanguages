var fp = require('./fp');
if ( ! exports )
    var exports = [ ];

var util = require('util');

///////////// ********************** ////////////////////

// Your solution for problem 1 must appear between this and matching
// end comment below

var convert = function (ns) {
    return 0;
}

////////// End of code for problem 1 ////////////////////


///////////// ********************** ////////////////////

// Your solution for problem 2 must appear between this and matching
// end comment below

var evalPoly = function (coeffs, x) {
    return 0;
}

////////// End of code for problem 2 ////////////////////


///////////// ********************** ////////////////////

// Your solution for problem 3 must appear between this and matching
// end comment below

var pathcps = function (n, bst) {
    return 0;
}

////////// End of code for problem 3 ////////////////////


///////////// ********************** ////////////////////

// Your solution for problem 4 must appear between this and matching
// end comment below

var analyze_paths = function (tree_searches,reducer) {
    return 0;
};

////////// End of code for problem 4 ////////////////////


///////////// ********************** ////////////////////

// Your solution for problem 5 must appear between this and matching
// end comment below


var ave_path_length = function (bst) {
    return 0;
}

////////// End of code for problem 5 ////////////////////


///////////// ********************** ////////////////////

// Your solution for problem 6 must appear between this and matching
// end comment below

var bestPitcher = function (db) {
    return 0;
}

////////// End of code for problem 6 ////////////////////


///////////// ********************** ////////////////////

//// All test cases you add must be below this comment.  Everything
//// below this line will be stripped away to accomodate our more
//// extensive set of test cases when your submission is evaluated

// // Sample call for convert -- Problem 1
// 
// console.log("convert");
// console.log(
//     convert( [['a',1],['b',2],['c',3]])
// )
// 
// 
// // Sample call for evalPoly -- Problem 2
// 
// console.log("evalpoly");
// console.log(
//     evalPoly([6, 4, -7, 2], 2)
// );
// 
// /// Sample call for pathcps -- Problem 3
// 
// console.log("pathcps");
// 
// var t1 = [14, [7, [], [12, [], []]],
//           [26, [20, [17, [], []],
//                 [] ],
//            [31, [], []]]];
// 
// var t2 = [ 1,
//   [],
//   [ 2,
//     [],
//     [ 3,
//       [],
//       [ 4,
//         [],
//         [ 5, [], [ 6, [], [ 7, [], [ 8, [], [ 9, [], [] ] ] ] ] ] ] ] ] ];
// 
// var t3 = [ 20,
// 	   [ 10,
// 	     [ 5, [], [] ],
// 	     [ 15, [], [] ] ],
// 	   [ 30,
// 	     [ 25, [], [] ],
// 	     [ 35, [], [] ] ] ]
// 
// console.log(
//     pathcps(17,t1)
// );
// console.log(
//     pathcps(8,t2)
// );
// console.log(
//     pathcps(89,t3)
// );
// 
// 
// // Sample call for analyze paths -- Problem 4
// 
// console.log("analyze paths");
// 
// var trees = [ [31, t1], [7, t2], [15, t3] ];
// 
// 
// console.log(
//     analyze_paths(trees, function (x,y) { return (x < y ? x : y); })
// );
// console.log(
//     analyze_paths(trees, function (x,y) { return (x + y); })
// );
// console.log(
//     analyze_paths(trees, function (x,y) { return (x > y ? x : y); })
// );
// 
// // Sample call for ave_path_length -- Problem 5
// 
// 
// console.log(
//     ave_path_length(t1)
// );
// console.log(
//     ave_path_length(t2)
// );
// console.log(
//     ave_path_length(t3)
// );
// 
// 
// // Sample calls for bestPitcher -- Problem 6
// 
// console.log("bestPitcher");
// 
// var brewers = [ ["Anderson", [4,4], [1,9], [3,8]], 
//                 ["Guerra", [4,9], [2,6]], 
//                 ["Nelson", [5,7], [4,8], [3,5], [2,6]], 
//                 ["Peralta", [2,9], [5,3]], 
//                 ["Davies", [4,9], [0,9], [3,6], [3,7] ] 
//               ];
// 
// var cubs =   [ ["Lester", [4,9], [2,6], [1,8], [3,7]], 
//                 ["Hendricks", [5,5], [2,9], [2,7], [4,8]], 
//                 ["Arrieta", [3,4], [1,8], [3,7], [5,9]], 
//                 ["Lackey", [4,7], [5,4], [1,8]], 
//                 ["Montgomery", [6,9], [2,9], [4,6], [5,7] ] 
//               ];
// 
// console.log(
//     bestPitcher(brewers)
// );
// console.log(
//     bestPitcher(cubs)
// );
// 
