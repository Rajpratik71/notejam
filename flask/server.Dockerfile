
FROM python:2.7-alpine 

WORKDIR /src

ADD requirements.txt /src/requirements.txt

RUN pip install -r requirements.txt

ADD . /src

#RUN pip install flask

#Create database schema:

#cd YOUR_PROJECT_DIR/flask/
RUN python /src/db.py

#Start flask web server:

#RUN python runserver.py

EXPOSE 5000

ENTRYPOINT [ "python", "/src/runserver.py" ]
#ENTRYPOINT ["/src/init.sh"]
