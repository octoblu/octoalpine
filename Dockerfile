FROM alpine:latest
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk add -q --no-cache \
  curl docker openssh-client \
  python3 python3-dev \
  mdocml-apropos libc-dev gcc \
  bash fish vim \
  jq gettext coreutils nodejs

RUN python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /root/.cache

RUN pip3 install urwid
RUN pip3 install awscli logentries-lecli sen

RUN touch /.viminfo && chmod 777 /.viminfo
COPY config /usr/local/etc/omf

RUN curl --silent -L http://get.oh-my.fish > /tmp/install \
  && fish /tmp/install --noninteractive --path=/usr/local/share/omf --config=/usr/local/etc/omf \
  && rm /tmp/install

RUN curl -o /usr/local/bin/docker-swarm-diff -fsSL https://github.com/octoblu/docker-swarm-diff/releases/download/v1.0.3/docker-swarm-diff-linux-amd64 \
  && chmod +x /usr/local/bin/docker-swarm-diff \
  && ln -s /usr/local/bin/docker-swarm-diff /usr/local/bin/dsd

RUN mkdir -p /usr/local/cache/sen
RUN chmod -R 777 /usr/local

ENV XDG_CONFIG_HOME=/usr/local/etc
ENV XDG_DATA_HOME=/usr/local/share
ENV XDG_CACHE_HOME=/usr/local/cache
