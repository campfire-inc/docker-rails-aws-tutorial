FROM ruby:2.6.3-slim-buster

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN apt-get update -qq && \
    apt-get install -y nodejs npm libsqlite3-dev build-essential openssl

RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./

RUN bundle install --without test development --jobs 4 --retry 3

COPY . .

RUN mkdir -p ./tmp/sockets ./tmp/pids

ENV RAILS_ENV production
# DO NOT insert this line in git with actual production.
ENV RAILS_MASTER_KEY a7f9041eb7389aa2ee89391707e45bbb

ADD docker/nginx/*.conf /etc/nginx/
ADD docker/nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/

CMD ["bundle", "exec", "rails", "s"]
