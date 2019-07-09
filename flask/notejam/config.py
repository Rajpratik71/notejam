import os
import urllib
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
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL')
    #SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')
    #TODO: pass in password with environment variable
    params = urllib.quote_plus('DRIVER={ODBC Driver 13 for SQL Server};SERVER=notejamsql.database.windows.net;DATABASE=notejamdb;UID=notejamadmin;PWD=')
    SQLALCHEMY_DATABASE_URI = "mssql+pyodbc:///?odbc_connect=%s" % params
    SQLALCHEMY_DATABASE_URI = '__SQLALCHEMY_DATABASE_URI_CI_CHANGE_VAR__'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://' + os.environ.get("RDS_USERNAME") + ':' + os.environ.get("RDS_PASSWORD") + "@" + os.environ.get("RDS_ENDPOINT") + '/notejam'

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
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')


class TestingConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')
