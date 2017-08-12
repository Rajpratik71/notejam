import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')


class ProductionConfig(Config):
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = 'pymysql://%s:%s@%s:%s/%s' % (
            os.getenv('MYSQL_USER', 'notejam'),
            os.getenv('MYSQL_PWD', ''),
            os.getenv('MYSQL_SERVICE_HOST', 'mysql'),
            os.getenv('MYSQL_SERVICE_PORT_MYSQL', '3306'),
            os.getenv('MYSQL_DB', 'notejam'))


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
