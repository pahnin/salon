# Dockerfile development version
FROM ruby:2.7.2 AS salon_app_development

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs yarn build-essential libpq-dev nodejs

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN gem install rails

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install rails bundler
RUN bundle install

COPY . .

RUN rm -rf node_modules vendor
RUN bundle install
RUN chown -R user:user /opt/app

USER $USER_ID
WORKDIR $INSTALL_PATH

CMD bash tail -f