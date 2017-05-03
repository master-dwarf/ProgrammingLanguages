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
var r1 = router.route('/user');

//The r1 CRUD interface | GET
r1.get(function(req,res,next){  // req - request, res - response

    console.log("/user GET");

    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect");

        var query = conn.query('SELECT * FROM t_user',function(err,rows){

            if(err){
                console.log(err);
                return next("Mysql error, check your query");
            }
            res.render('user',{title:"RESTful Packer Example",data:rows});
         });

    });

});

//The r1 CRUD interface for posting data to DB | POST
r1.post(function(req,res,next){

    console.log("/user POST");

    //validation
    req.assert('name','Name is required').notEmpty();
    req.assert('email','A valid email is required').isEmail();
    req.assert('password','Enter a password 6 - 20').len(6,20);

    var errors = req.validationErrors();
    if(errors){
        res.status(422).json(errors);
        return;
    }

    //get data
    var data = {
        name:req.body.name,
        email:req.body.email,
        password:req.body.password
     };

    //inserting into mysql
    req.getConnection(function (err, conn){

        if (err) return next("Cannot Connect");

        var query = conn.query("INSERT INTO t_user set ? ",data, function(err, rows){

           if(err){
                console.log(err);
                return next("Mysql error, check your query");
           }
          res.sendStatus(200);
        });
     });

});


// Route r2 illustrates single parameter user_id route (GET,DELETE,PUT)
var r2 = router.route('/user/:user_id');

// route.all is extremely useful. You can use it to do things required
// for all r2 routes. For example you might need to do a validation
// everytime route /user/:user_id is hit.

r2.all(function(req,res,next){
    var user_id = req.params.user_id;
    console.log("Anything all r2 routes need? You can do it here");
    console.log(req.params);
    next();
});

//get data to update
r2.get(function(req,res,next){

    var user_id = req.params.user_id;

    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect");

        var query = conn.query("SELECT * FROM t_user WHERE user_id = ? ",[user_id],function(err,rows){

            if(err){
                console.log(err);
                return next("Mysql error, check your query");
            }

            //if user not found
            if(rows.length < 1)
                return res.send("User Not found");

            res.render('edit',{title:"Edit user",data:rows});
        });
    });

});

//update data
r2.put(function(req,res,next){
    var user_id = req.params.user_id;

    //validation
    req.assert('name','Name is required').notEmpty();
    req.assert('email','A valid email is required').isEmail();
    req.assert('password','Enter a password 6 - 20').len(6,20);

    var errors = req.validationErrors();
    if(errors){
        res.status(422).json(errors);
        return;
    }

    //get data
    var data = {
        name:req.body.name,
        email:req.body.email,
        password:req.body.password
     };

    //inserting into mysql
    req.getConnection(function (err, conn){

        if (err) return next("Cannot Connect");

        var query = conn.query("UPDATE t_user set ? WHERE user_id = ? ",[data,user_id], function(err, rows){

           if(err){
                console.log(err);
                return next("Mysql error, check your query");
           }

          res.sendStatus(200);

        });

     });

});

//delete data
r2.delete(function(req,res,next){

    var user_id = req.params.user_id;

     req.getConnection(function (err, conn) {

        if (err) return next("Cannot Connect");

        var query = conn.query("DELETE FROM t_user  WHERE user_id = ? ",[user_id], function(err, rows){

             if(err){
                console.log(err);
                return next("Mysql error, check your query");
             }

             res.sendStatus(200);

        });
        //console.log(query.sql);

     });
});


// Route r3 illustrates a fully  paramterized GET route
var r3 = router.route('/param_test');

r3.all(function(req,res,next){
    console.log("Done for all r3 routes ");
    next();
});

//get data to display based on params
r3.get(function(req,res,next){

    console.log("r3 GET ");
    var user_email = req.param('email');
    console.log("email " + user_email);
    var user_name = req.param('name');
    console.log("name " + user_name);

    // Sample request: http://localhost:3000/param_test?name=Randall+Cobb&email=nelson@gmail.com
    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect");

        var query = conn.query("SELECT * FROM t_user WHERE email = ? OR name = ? ",[user_email, user_name],function(err,rows){

            if(err){
                console.log(err);
                return next("Mysql error, check your query");
            }

            //if user not found
            if(rows.length < 1)
                return res.send("User Not found");

            res.render('user',{title:"Sample of using params",data:rows});
        });
    });
});

// Export so we can be seen in the server
module.exports.router = router;
