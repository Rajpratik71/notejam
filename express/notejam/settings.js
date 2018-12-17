var settings = {
    local: {
        db: "notejam.db",
        dsn: "sqlite://notejam.db"
    },
    development: {
        dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_prod"
    },
    prod: {
        dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_prod"
    }
};

var env = process.env.NODE_ENV;
if (!env) {
  env = 'local'
};
module.exports = settings[env];
