var express = require('express');
var session = require('express-session');
var path = require('path');
var favicon = require('static-favicon');
var cookieParser = require('cookie-parser');
var flash = require('connect-flash');
var bodyParser = require('body-parser');
var orm = require('orm');
var expressValidator = require('express-validator');
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var shell = require('shelljs');

var users = require('./routes/users');
var pads = require('./routes/pads');
var notes = require('./routes/notes');
var settings = require('./settings');

var app = express();


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(expressValidator());
app.use(cookieParser());
app.use(session({cookie: { maxAge: 60000 }, secret: 'secret'}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(path.join(__dirname, 'public')));

// DB configuration
var sqlite3 = require('sqlite3').verbose();

var env = process.env.NODE_ENV;
if (!env) {
  env = 'local'
}

console.log(process.version);

if (env === "local") {
  var db = new sqlite3.Database(settings.db);
  shell.exec('NODE_ENV=local node db.js', function(code, stdout, stderr) {
  });
}
else {
  var db = require('mysql').createConnection(settings.dsn);
  console.log("DB_HOST is: " + process.env.DB_HOST);
  shell.exec('NODE_ENV=prod node db.js', function(code, stdout, stderr) {
  });
}


orm.settings.set("instance.returnAllErrors", true);
app.use(orm.express(settings.dsn, {
  define: function (db, models, next) {
    db.load("./models", function (err) {
      models.User = db.models.users;
      models.Pad = db.models.pads;
      models.Note = db.models.notes;
      console.log(err);
      next();
    });
  }
}));

var blacklog = require("./logger");

blacklog.debug("Overriding 'Express' logger");
app.use(require('morgan')({ "stream": blacklog.stream }));

// Flash Messages configuration
app.use(function(req, res, next){
  res.locals.flash_messages = {
    'success': req.flash('success'),
    'error': req.flash('error')
  }
  next();
});

// Inject request object and user pads in view scope
app.use(function(req, res, next){
  res.locals.req = req;

  if (req.isAuthenticated()) {
    req.user.getPads(function(i, pads) {
      res.locals.pads = pads;
      next();
    });
  } else {
    next();
  }
});

app.use('/', users);
app.use('/', pads);
app.use('/', notes);

/// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  console.log(err);
  next(err);
});

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
    console.log(err);
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
  console.log(err);
});

module.exports = app;
