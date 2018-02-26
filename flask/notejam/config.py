import os
import pymysql
basedir = os.path.abspath(os.path.dirname(__file__))

# Terraform will handle provisioning this. More flexible.

notejam_user = os.environ['db_username']
notejam_password = os.environ['db_password']
database_endpoint = os.environ['db_url']
port = os.environ['db_port']
db_name = os.environ['db_name']

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://'+notejam_user+':'+notejam_password+'@'+database_endpoint+':'+port+'/'+db_name

class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
