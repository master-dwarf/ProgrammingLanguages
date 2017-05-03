var express  = require('express'),
    path     = require('path'),
    bodyParser = require('body-parser'),
    app = express(),
    expressValidator = require('express-validator');


/*Set EJS as the template Engine*/
app.set('views','./views');
app.set('view engine','ejs');

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(expressValidator());

/*MySql connection*/
var connection  = require('express-myconnection'),
    mysql = require('mysql');

app.use(

    connection(mysql,{
        // host     : '127.0.0.1',	// Use one of these hosts according to your location
       host     : 'labdb.acs.uwosh.edu',
        user     : 'hilgeg46',	// Your MySQL user name
        password : '0600646',	// Your MySQL password
        database : 'hilgeg46',	// Your DB name
        debug    : false  //set to true if you want to see debug logger
    },'request')

);

app.get('/',function(req,res){
    res.send('Welcome');
});



var router = express.Router();// calling the outside routes
var index = require('./router/index').router;
app.use('/',index);

//start Server
var server = app.listen(3000,function(){

   console.log("Listening on port %s",server.address().port);

});
