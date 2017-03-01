FROM alpine:latest
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk add -q --no-cache \
  curl docker openssh-client \
  bash jq python2 python2-dev py-setuptools \
  gettext coreutils nodejs

RUN curl -fsSLO https://github.com/docker/machine/releases/download/v0.9.0/docker-machine-Linux-x86_64
RUN mv docker-machine-Linux-x86_64 /usr/local/bin/docker-machine
RUN chmod +x /usr/local/bin/docker-machine

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz
RUN tar --strip-components=1 -xvzf docker-1.13.1.tgz -C /usr/local/bin
RUN chmod +x /usr/local/bin/docker

RUN adduser -D -u 501 octoblu

RUN easy_install-2.7 pip && pip install --upgrade pip
RUN pip install awscli logentries-lecli
