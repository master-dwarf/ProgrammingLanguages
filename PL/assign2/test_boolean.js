var parserName = "boolean";
var parser;
var selectedTest = process.argv[2];

/////////////////////// define the test suite /////////////////////////
var tests= [ /*  0 */ [ "true", true ],
             /*  1 */ [ "false", false ],
             /*  2 */ [ "true  && true", true],
             /*  3 */ [ "false && true", false],
             /*  4 */ [ "true  && false", false],
             /*  5 */ [ "false && false", false],
             /*  6 */ [ "true  || true", true],
             /*  7 */ [ "false || true", true],
             /*  8 */ [ "true  || false", true],
             /*  9 */ [ "false || false", false],
             /* 10 */ [ "! true", false],
             /* 11 */ [ "! false", true],
             /* 12 */ [ "!!false", false],
             /* 13 */ [ "!!!!! false", true],
             /* 14 */ [ "true  !& true", false],
             /* 15 */ [ "false !& true", true],
             /* 16 */ [ "true  !& false", true],
             /* 17 */ [ "false !& false", true],
             /* 18 */ [ "true  !| true", false],
             /* 19 */ [ "false !| true", false],
             /* 20 */ [ "true  !| false", false],
             /* 21 */ [ "false !| false", true],
             /* 22 */ [ "true  @ true", false],
             /* 23 */ [ "false @ true", true],
             /* 24 */ [ "true  @ false", true],
             /* 25 */ [ "false @ false", false],             
             /* 26 */ [ "false && false || true", true],             
             /* 27 */ [ "true || false && false", true],
             /* 28 */ [ "true !& true !| false", true],             
             /* 29 */ [ "false !| true !& true", true],
             /* 30 */ [ "false && (false || true)", false],             
             /* 31 */ [ "(true || false) && false", false],
             /* 32 */ [ "true !& (true !| false)", true],             
             /* 33 */ [ "(false !| true) !& true", true],
             /* 34 */ [ "true @ true !| true", true],
             /* 35 */ [ "(true @ true) !| true", false],
             /* 36 */ [ "false && true @ true", true],
             /* 37 */ [ "false && (true @ true)", false],
             /* 38 */ [ "true @ false !| true && false @ true || false", true],
             /* 39 */ [ "!!false||false!&false!|false&&(!!!false@false)", false],
             /* 40 */ [ "!!false||false!&false!|false&&!!!false@true", true]
	   ];

///////////////////////// load the parser /////////////////////////////
process.stdout.write("\nLoading parser... ");
try {
    parser = require('./' + parserName);
    console.log(" done\n");
} catch (e) {
    console.log("\nError loading the parser from file "+ parserName + ".js\n");
    process.exit(1);
}

///////////////////////// run the test(s) /////////////////////////////
if (selectedTest) {
    if ( (/^[0-9]+$/.test(selectedTest)) &&
	 (Number(selectedTest) < tests.length) ) {
	parseInput(selectedTest);
    } else {
	console.log("Error: Test number is invalid or out of range");
	process.exit(1);
    }
} else { 
    console.log("===========================");
    console.log("Test suite for", parserName+".js");
    console.log("===========================");
    for(var i=0; i<tests.length; i++) {
	parseInput(i);
    }
}

/////////////// helper function to perform one test //////////////////
function parseInput(testNumber) {
    var input = tests[testNumber][0];
    var output;
    var expected = tests[testNumber][1];
    try {
	console.log("Test #",testNumber,"    Input = ", input);
	output = parser.parse( input );
	console.log("\t\t\t\t\tTest ", 
		    output === expected ? "PASSED" : "FAILED");
    } catch (e) {
	// exception is presumably due to a parsing error
	console.log(e.message);
    }
    console.log("----------------------------------------------------");
}
    

