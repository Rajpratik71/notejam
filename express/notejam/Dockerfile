FROM keymetrics/pm2:8-alpine

CMD cd /app && npm run start:prod
EXPOSE 3000

# Installs all dependencies of the current concert.
RUN mkdir /app && apk add --virtual build-dependencies && apk add yarn python make gcc g++
COPY package.json /app/package.json
RUN cd /app && ls -l && yarn install

COPY . /app