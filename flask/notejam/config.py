import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = '__SQLALCHEMY_DATABASE_URI_CI_CHANGE_VAR__'


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')


class TestingConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')
