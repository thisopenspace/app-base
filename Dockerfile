FROM ruby:2.3.5-alpine

RUN ["/bin/bash", "-c", "set -o pipefail \
  && apt-get update \
  && apt-get -y install apt-transport-https curl \
  && echo \"deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main\" > /etc/apt/sources.list.d/pgdg.list \
  && curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"]

RUN ["/bin/bash", "-c", "set -o pipefail \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash -"]

RUN ["/bin/bash", "-c", "export CLOUD_SDK_REPO=\"cloud-sdk-$(lsb_release -c -s)\" \
  && echo \"deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main\" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"]

RUN apt-get update \
  && apt-get -y install \
      libpq-dev \
      libreadline-dev\
      nodejs \
      postgresql-client-9.4 \
      google-cloud-sdk \
      kubectl \
      imagemagick \
      build-essential \ 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ["/bin/bash", "-c", "set -o pipefail \
  && gem install bundler \
  && curl -o- -L https://yarnpkg.com/install.sh | bash"]
