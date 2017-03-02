FROM alpine:latest
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk add -q --no-cache \
  curl docker openssh-client \
  bash jq python2 python2-dev py-setuptools \
  gettext coreutils nodejs fish vim

RUN adduser -D -u 501 octoblu
RUN touch /.viminfo && chown 501:501 /.viminfo

RUN easy_install-2.7 pip && pip install --upgrade pip
RUN pip install awscli logentries-lecli

COPY config /home/octoblu/.config/omf/
RUN chown -R octoblu:octoblu /home/octoblu/.config
RUN curl --silent -L http://get.oh-my.fish > /tmp/install \
  && su octoblu - -c 'fish /tmp/install --noninteractive --path=/home/octoblu/.local/share/omf --config=/home/octoblu/.config/omf' \
  && rm /tmp/install
