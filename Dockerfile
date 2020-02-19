FROM ruby:2.3-alpine

RUN apk add --update nginx build-base libffi-dev nodejs npm

ENV APP_HOME '/app'
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME/

RUN bundle install --jobs 10 --retry 5 --without staging development --deployment
RUN npm install

RUN npm run build
RUN bundle exec jekyll build

ENV VIRTUAL_HOST design-process.netguru.co
ENV LETSENCRYPT_HOST design-process.netguru.co
ENV LETSENCRYPT_EMAIL devops-team@netguru.co
