# notejam/management/commands/create_db.py
import sys
import logging
import MySQLdb

from django.core.management.base import BaseCommand, CommandError
from django.conf import settings

rds_host = 'notejam.cluster-cvlyuw8qs7ki.eu-west-1.rds.amazonaws.com'
db_name = 'notejam'
user_name = 'root'
password = 'C~54)B8C\M7$Qcd'
port = 3306

logger = logging.getLogger()
logger.setLevel(logging.INFO)


class Command(BaseCommand):
    help = 'Creates the initial database'

    def handle(self, *args, **options):
        print('Starting db creation')
        try:
            db = MySQLdb.connect(host=rds_host, user=user_name,
                                 password=password, db="mysql", connect_timeout=5)
            c = db.cursor()
            print("connected to db server")
            c.execute("""CREATE DATABASE notejam;""")
            c.execute(
                """GRANT ALL PRIVILEGES ON db_name.* TO 'root' IDENTIFIED BY 'C~54)B8C\M7$Qcd';""")
            c.close()
            print("closed db connection")
        except:
            logger.error(
                "ERROR: Unexpected error: Could not connect to MySql instance.")
            sys.exit()
