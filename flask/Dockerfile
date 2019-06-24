FROM python:2-alpine
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN python db.py
#RUN python tests.py
EXPOSE 5000
CMD ["python", "runserver.py"]
