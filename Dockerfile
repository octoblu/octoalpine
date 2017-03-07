FROM alpine:latest
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk add -q --no-cache \
  curl docker openssh-client \
  bash jq python2 python2-dev py-setuptools \
  gettext coreutils nodejs fish vim mdocml-apropos 

RUN touch /.viminfo && chmod 777 /.viminfo

RUN easy_install-2.7 pip && pip install --upgrade pip
RUN pip install awscli logentries-lecli

COPY config /usr/local/etc/omf
RUN curl --silent -L http://get.oh-my.fish > /tmp/install \
  && fish /tmp/install --noninteractive --path=/usr/local/share/omf --config=/usr/local/etc/omf \
  && rm /tmp/install

RUN chmod -R 777 /usr/local

ENV XDG_CONFIG_HOME=/usr/local/etc
ENV XDG_DATA_HOME=/usr/local/share
