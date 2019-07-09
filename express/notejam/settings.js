var settings = {
  production: {
    dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_prod"
    db: "storage/notejam.db",
    dsn: "sqlite://storage/notejam.db"
  },
  development: {
    dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_prod"
    db: "notejam.db",
    dsn: "sqlite://notejam.db"
  },
  test: {
    db: "notejam_test.db",
    dsn: "sqlite://notejam_test.db"
  }
};

var env = process.env.NODE_ENV;
if (!env) {
  env = 'local'
};
module.exports = settings[env];
