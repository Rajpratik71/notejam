var sqlite3 = require('sqlite3').verbose();
var async = require('async');

var settings = require('./settings');

var env = process.env.NODE_ENV;
if (!env) {
  env = 'local'
}

if (env === 'local') {
  var db = new sqlite3.Database(settings.db);
} else {
  var db = require('mysql').createConnection(settings.dsn);
// mini sqlite -> mysql conversion driver
  db.run = function (sql, params, cb) {
    sql = sql.replace("AUTOINCREMENT", "AUTO_INCREMENT");
    sql = sql.replace(/default current_timestamp/g, "timestamp default current_timestamp");
    references = /,([a-z_]+) ([A-Z ]+) REFERENCES ([a-z(]+\))/g;
    foreignkeys = [];
    while(match = references.exec(sql)) {
      foreignkeys.push("FOREIGN KEY (" + match[1] + ") REFERENCES " + match[3]);
    }
    if(foreignkeys.length > 0) {
      sql = sql.replace(/REFERENCES [a-z(]+\)/g, "");
      sql = sql.replace(");", "," + foreignkeys.join(',') + ");");
    }
    this.query(sql, params, cb);
  };
  db.close = function (err) {
    this.end(err);
  };
}


var functions = {
  createTables: function(next) {
    async.series({
      createUsers: function(callback) {
        db.run("CREATE TABLE IF NOT EXISTS users (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," +
            "email VARCHAR(75) NOT NULL," +
            "password VARCHAR(128) NOT NULL);", [],
            function() { callback(null); });
      },
      createPads: function(callback) {
        db.run("CREATE TABLE IF NOT EXISTS pads (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," +
            "name VARCHAR(100) NOT NULL," +
            "user_id INTEGER NOT NULL REFERENCES users(id));", [],
            function() { callback(null); })
      },
      createNotes: function(callback) {
        db.run("CREATE TABLE IF NOT EXISTS notes (" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," +
            "pad_id INTEGER NULL REFERENCES pads(id)," +
            "user_id INTEGER NULL REFERENCES users(id)," +
            "name VARCHAR(100) NOT NULL," +
            "text text NOT NULL," +
            "created_at default current_timestamp," +
            "updated_at default current_timestamp);", [],
            function() { callback(null); });
      }
    },
    function(err, results) {
      next();
    });
  },

  applyFixtures: function(next) {
    this.truncateTables(function() {
      async.series([
        function(callback) {
          db.run("INSERT INTO users VALUES (1, 'user1@example.com', " +
                 "'$2a$10$mhkqpUvPPs.zoRSTiGAEKODOJMljkOY96zludIIw.Pop1UvQCTx8u')", [],
                function() { callback(null) });
        },
        function(callback) {
          db.run("INSERT INTO users VALUES (2, 'user2@example.com', " +
                 "'$2a$10$mhkqpUvPPs.zoRSTiGAEKODOJMljkOY96zludIIw.Pop1UvQCTx8u')", [],
                function() { callback(null) });
        },
        function(callback) {
          db.run("INSERT INTO pads VALUES (1, 'Pad 1', 1)", [],
                function() { callback(null) });
        },
        function(callback) {
          db.run("INSERT INTO pads VALUES (2, 'Pad 2', 1)", [],
                function() { callback(null) });
        },
        function(callback) {
          db.run("INSERT INTO notes VALUES (1, 1, 1, 'Note 1', 'Text', 1, 1)", [],
                function() { callback(null) });
        },
        function(callback) {
          db.run("INSERT INTO notes VALUES (2, 1, 1, 'Note 2', 'Text', 1, 1)", [],
                function() { callback(null) });
        }
      ], function(err, results) {
        next();
      })
    });
  },

  truncateTables: function(next) {
    async.series([
      function(callback) {
        db.run("DELETE FROM users;", [],
              function() { callback(null) });
      },
      function(callback) {
        db.run("DELETE FROM notes;", [],
              function() { callback(null) });
      },
      function(callback) {
        db.run("DELETE FROM pads;", [],
              function(result) { callback(null); });
      }
    ], function(err, results) {
      next();
    })
  },

  removeTables: function(done) {
    async.series([
      function(callback) {
        db.run("DROP TABLE users;", [],
          function() { callback(null) });
      },
      function(callback) {
        db.run("DROP TABLE notes;", [],
          function() { callback(null) });
      },
      function(callback) {
        db.run("DROP TABLE pads;", [],
          function(result) { callback(null); });
      }
    ], function(err, results) {
      done();
    })
  }
};

if (require.main === module) {
  functions.createTables(function() {
    console.log("DB successfully initialized");
  });
  functions.applyFixtures(function() {
    db.close();
    console.log("Data successfully loaded");
  });
}

module.exports = functions;
