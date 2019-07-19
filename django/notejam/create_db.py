import os
import sys
import logging
import MySQLdb
from django.core.management import call_command, execute_from_command_line

rds_host = 'notejam-17ov4sx22c5q3.cluster-ciyk7lf4cmwo.eu-west-1.rds.amazonaws.com'
db_name = 'notejam'
user_name = 'root'
password = 'sdfh834rn3443FSDFfff'
port = 3306

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Manual lambda for creating the database and making the migrations
def handle(self, *args, **options):
    print('Starting db creation')
    try:
        db = MySQLdb.connect(host=rds_host, user=user_name,
                             password=password, db=db_name, connect_timeout=5)
        c = db.cursor()
        print("connected to db server")
        c.execute("""CREATE DATABASE IF NOT EXISTS notejam;""")
        c.execute(
            """GRANT ALL PRIVILEGES ON db_name.* TO 'root' IDENTIFIED BY 'sdfh834rn3443FSDFfff';""")
        c.close()
        print("closed db connection")
        print("migrating")
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "notejam.settings")
        execute_from_command_line(['', 'migrate'])
        print("finsihed migrating")
    except Exception as e:
        logger.error("ERROR: Unexpected error: Could not connect to MySql instance. " + str(e) + ".....")
        sys.exit()
