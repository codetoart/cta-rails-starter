FROM ruby:2.6-alpine

ARG RAILS_ENV=development

RUN apk add --update --no-cache \
  build-base \
  postgresql-client \
  postgresql-dev \
  tzdata \
  libxslt-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /ctapad-backend

RUN gem update --system
RUN gem install bundler

ADD . /ctapad-backend

EXPOSE 3030

CMD bundle exec rails s -b 0.0.0.0 -p 3030
