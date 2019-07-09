FROM python:2-alpine

RUN apk add --no-cache --virtual .calzone_deps python3 build-base python-dev openssl-dev libffi-dev
RUN python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --upgrade pip setuptools && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  rm -r /root/.cache

RUN mkdir /src
COPY requirements.txt /src/
WORKDIR /src/
RUN pip install -r requirements.txt
COPY . /src
EXPOSE 5000
CMD [ "python", "./runserver.py" ]
