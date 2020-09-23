FROM ruby:2.6.3-slim-stretch

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV production

ADD docker/nginx/*.conf /etc/nginx/
ADD docker/nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/

CMD ["bundle", "exec", "rails", "s"]
