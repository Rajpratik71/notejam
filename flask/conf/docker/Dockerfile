#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Environment variables will be set by parameter store

#Install.
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y python-pip
RUN pip install virtualenv
RUN pip install pymysql
RUN apt-get install -y git
RUN git clone https://github.com/therenegadeoffunk/notejam

# Define working directory.
WORKDIR /notejam/flask
RUN pip install -r requirements.txt
RUN python db.py

EXPOSE 5000
# Define default command.
CMD ["python", "runserver.py"]
