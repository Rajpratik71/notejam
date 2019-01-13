import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    LOCAL_DB = 'sqlite:///' + os.path.join(basedir, 'notejam.db')
    SQLALCHEMY_DATABASE_URI = os.environ.get("RDS_ENDPOINT", default="LOCAL_DB")



class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
