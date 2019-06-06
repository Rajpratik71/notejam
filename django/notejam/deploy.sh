#!/bin/bash
set -e

python manage.py collectstatic --noinput
# Cheating, making sure that migrate is working
export LAMBDA_TASK_ROOT=/home
# Create an admin when deploying for the first time
# echo "from django.contrib.auth.models import User; import os; User.objects.create_superuser('root', 'my@email.com', os.environ.get('DJANGO_ADMIN_PASSWORD','MyPassword')) if len(User.objects.filter(email='my@email.com')) == 0 else print('Admin exists')"|python manage.py shell
# We need the so, Lambda env does not contain it.
#cp ./include/_sqlite3.so .
cp ./include/libmysqlclient.so.18 .
sls deploy
# Wait for Lambda coldstart
sleep 10
sls invoke -f initdb -s dev -l
rm libmysqlclient.so.18
