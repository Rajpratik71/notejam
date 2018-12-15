FROM keymetrics/pm2:8-alpine

CMD npm run start:prod
EXPOSE 3000

# Installs all dependencies of the current concert.
RUN apk add yarn
COPY package.json package.json
RUN ls -l; yarn install

COPY . .