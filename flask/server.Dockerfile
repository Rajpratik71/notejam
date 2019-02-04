FROM lbosqmsft/mssql-python-pyodbc

WORKDIR /src

ADD requirements.txt /src/requirements.txt

RUN pip install -r requirements.txt

ADD . /src

#Create database schema:
RUN python /src/db.py

EXPOSE 5000

#Start flask web server:
ENTRYPOINT [ "python", "/src/runserver.py" ]

