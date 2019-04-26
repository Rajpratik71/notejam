FROM ruby:2.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      postgresql-client nodejs \
    && rm -rf /var/lib/apt/lists/*

# RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    # && apt-get install -y nodejs

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

RUN bin/rake db:migrate RAILS_ENV=development
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
