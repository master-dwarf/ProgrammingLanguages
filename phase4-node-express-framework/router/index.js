//RESTful router
var express  = require('express'),
    path     = require('path'),
    bodyParser = require('body-parser'),
    app = express(),
    expressValidator = require('express-validator');

var router = express.Router();

// This is router "middleware", which is invoked everytime we access
// the url / and anything after / ,e.g., /user , /user/7,
// /param_test?name=Randall+Cobb&email=nelson@gmail.com. We can use
// this for doing validation, authetication for every route started
// with /

router.use(function(req, res, next) {  // req - request, res - response
    console.log(req.method, req.url);
    next();			// Here just display a message and proceed
});

// Route r1
var r1 = router.route('/students');
// /param_test?citizenship=United+States

r1.all(function(req,res,next){
    next();
});

//The r1 CRUD interface | GET
r1.get(function(req,res,next){  // req - request, res - response

    var citizenship = req.param("citizenship");

    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect");

        var query = conn.query('select t4.email as email, t4.first_name as first_name, t4.last_name as last_name, t4.institue_name as firstChoice, t5.institue_name as secondChoice from institutes as t5 inner join (select t3.email, t3.first_name, t3.last_name, t3.sending_institute_id, t4.institue_name, t3.institute_id_2 from institutes as t4 inner join (select t1.email, t1.first_name, t1.last_name, t1.sending_institute_id, t2.institute_id_1, t2.institute_id_2 from student_choice_of_schools as t2 inner join (select t1.email, t1.first_name, t1.last_name, t1.sending_institute_id from student_names as t1 where t1.citizenship <> ?) as t1 where t2.students_email = t1.email) as t3 where t4.institute_ID = t3.institute_id_1) as t4 where t5.institute_ID = t4.institute_id_2 order by t4.sending_institute_id',[citizenship], function(err,rows){

            if(err){
                console.log(err);
                return next("Mysql error, check your query");
            }
            if(rows.length < 1)
                return res.send("Country Not found");

            res.render('student',{title:"All Students for" + citizenship,data:rows});
         });

    });

});

// Route r3 illustrates a fully  paramterized GET route
var r3 = router.route('/fte');
// /param_test?citizenship=United+States&term_id=2

r3.all(function(req,res,next){
    next();
});

//get data to display based on params
r3.get(function(req,res,next){
    var citizenship = req.param('citizenship');
    var term_id = req.param('term_id');

    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect");

        var query = conn.query("select round(bachelors,4) as bachelorFTE, round(masters,4) as mastersFTE from (select sum(t1.undergrad_FTE) as bachelors from student_names as t1 where t1.citizenship <> ? and term_id = ?) as t1 join (select sum(t2.G_FTE_withdrawl) as masters from student_names as t2 where t2.citizenship <> ? and term_id = ?) as t2", [citizenship, term_id, citizenship, term_id], function(err,rows){

            if(err){
                console.log(err);
                return next("Mysql error, check your query");
            }

            //if user not found
            if(rows.length < 1)
                return res.send("Term ID or Country Not found");

            res.render('FTE',{title:"FTE data for "+citizenship+" Students in term "+term_id,data:rows});
        });
    });
});

// Export so we can be seen in the server
module.exports.router = router;
