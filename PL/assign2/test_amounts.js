var parserName = "amounts";
var parser;
var selectedTest = process.argv[2];

/////////////////////// define the test suite /////////////////////////
var tests= [ /*  0 */ [ "$1", "YES" ],
             /*  1 */ [ "$1.23", "YES" ],
             /*  2 */ [ "$***1", "YES" ],
             /*  3 */ [ "$***1.23", "YES" ],
             /*  4 */ [ "$***0.12", "YES" ],
             /*  5 */ [ "$1.02", "YES" ],
             /*  6 */ [ "$1,234", "YES" ],
             /*  7 */ [ "$*10.00", "YES" ],
             /*  8 */ [ "$***************1,234,567.89", "YES" ],   
             /*  9 */ [ "$.12", "NO" ],    
             /* 10 */ [ "$01.23", "NO" ],
             /* 11 */ [ "*$*0*1.23", "NO" ],
             /* 12 */ [ "$**0*1.23", "NO" ],
             /* 13 */ [ "1.23", "NO" ],
             /* 14 */ [ "$1234", "NO" ],
             /* 15 */ [ "$123,4", "NO" ],
             /* 16 */ [ "$1,234.5", "NO" ],
             /* 17 */ [ "$***5.", "NO" ],
             /* 18 */ [ "$*1.234", "NO" ]
	   ];

///////////////////////// load the parser /////////////////////////////
process.stdout.write("\nLoading parser... ");
try {
    parser = require('./' + parserName);
    console.log(" done\n");
} catch (e) {
    console.log("\nError loading the parser from file " + parserName + ".js\n");
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
    var outcome = tests[testNumber][1];
    try {
	console.log("Test #",testNumber,"    Input = ", input);
	parser.parse( input );
	console.log("\t\t\t\t\tTest ", outcome === "YES" ? "PASSED" : "FAILED");
    } catch (e) {
	// exception is presumably due to a parsing error
	console.log(e.message);
	console.log("\t\t\t\t\tTest ", outcome !== "YES" ? "PASSED" : "FAILED");
    }
    console.log("----------------------------------------------------");
}
    

