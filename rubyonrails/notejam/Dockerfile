FROM ruby:2.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      postgresql-client nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["./entrypoint.sh"]
