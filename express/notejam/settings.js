var settings = {
    local: {
        dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_unit"
    },
    development: {
        dsn: "mysql://"+process.env.DB_USER+":"+process.env.DB_PASSWORD+"@"+process.env.DB_HOST+"/notejam_dev"
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
