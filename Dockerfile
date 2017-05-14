FROM ruby:2.3.0
RUN mkdir -p /usr/app

ENV NODE_ENV production

RUN ["/bin/bash", "-c", "set -o pipefail \
  && apt-get update \
  && apt-get -y install apt-transport-https \
  && echo \"deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main\" > /etc/apt/sources.list.d/pgdg.list \
  && curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"]

RUN ["/bin/bash", "-c", "set -o pipefail \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash -"]

RUN apt-get update \
  && apt-get -y install \
      libpq-dev \
      libreadline-dev\
      nodejs \
      postgresql-client-9.4 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ["/bin/bash", "-c", "set -o pipefail \
  && gem install bundler \
  && curl -o- -L https://yarnpkg.com/install.sh | bash"]
