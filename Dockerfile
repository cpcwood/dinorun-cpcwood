# dinorun-production-container-image
# ================

# Compile Assets
# ================

FROM ruby:2.7.2-alpine AS builder

ENV RAILS_ENV=production \
  NODE_ENV=production \
  APP_HOME=/opt/app

ENV BUNDLE_PATH=$APP_HOME/vendor/bundle \
  GEM_PATH=$APP_HOME/vendor/bundle \
  GEM_HOME=$APP_HOME/vendor/bundle \
  BUNDLE_APP_CONFIG=$APP_HOME/vendor/bundle

RUN apk add --no-cache \
  build-base \
  postgresql-dev \
  nodejs \
  yarn \
  git

RUN mkdir -p $APP_HOME $APP_HOME/vendor/bundle $APP_HOME/tmp
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle config set without development:test:assets && \
  bundle config set bin $GEM_PATH/bin && \
  bundle install

COPY package.json yarn.lock $APP_HOME/
RUN yarn install --production=true

COPY . $APP_HOME

ENV SECRET_KEY_BASE=1234567890

RUN bundle exec rails assets:precompile && \
  rm -rf $APP_HOME/node_modules && \
  rm -rf $APP_HOME/app/frontend/packs && \
  rm -rf $APP_HOME/log/* && \
  rm -rf $APP_HOME/spec && \
  rm -rf $APP_HOME/storage/* && \
  rm -rf $APP_HOME/tmp/* && \
  rm -rf $APP_HOME/vendor/bundle/ruby/2.7.0/cache/ && \
  find $APP_HOME/vendor/bundle/ruby/2.7.0/gems/ -name "*.c" -delete && \
  find $APP_HOME/vendor/bundle/ruby/2.7.0/gems/ -name "*.o" -delete



# Create app image
# ================
FROM ruby:2.7.2-alpine

ENV RAILS_ENV=production \
  NODE_ENV=production \
  APP_HOME=/opt/app

ENV BUNDLE_PATH=$APP_HOME/vendor/bundle \
  GEM_PATH=$APP_HOME/vendor/bundle \
  GEM_HOME=$APP_HOME/vendor/bundle \
  BUNDLE_APP_CONFIG=$APP_HOME/vendor/bundle \
  PATH=$APP_HOME/vendor/bundle/bin:$APP_HOME/vendor/bundle:$APP_HOME/node_modules/.bin:$PATH

RUN apk add --no-cache \
  tzdata \
  postgresql-client && \
  cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
  echo "Europe/London" > /etc/timezone

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN addgroup -S docker && \
  adduser -S -G docker docker

USER docker

COPY --chown=docker:docker --from=builder $APP_HOME $APP_HOME

EXPOSE 5000
CMD ["./scripts/docker-startup-app.sh"]