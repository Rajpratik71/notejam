From python:2

Add flask /home/circleci/project/flask
WORKDIR /home/circleci/project/flask

CMD . .env/bin/activate && python runserver.py
