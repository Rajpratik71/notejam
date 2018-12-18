FROM keymetrics/pm2:8-jessie

CMD cd /app && npm run start:prod
EXPOSE 3000

# Installs all dependencies of the current concert.
RUN mkdir /app && chmod -R 777 /app && apt-get update && curl -o- -L https://yarnpkg.com/install.sh | bash
COPY package.json /app/package.json
RUN cd /app && ls -l && yarn install

COPY . /app