FROM alpine:latest
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk add -q --no-cache \
  curl docker openssh-client \
  bash jq python2 python2-dev py-setuptools \
  gettext coreutils nodejs

RUN adduser -D -u 501 octoblu

RUN easy_install-2.7 pip && pip install --upgrade pip
RUN pip install awscli logentries-lecli
