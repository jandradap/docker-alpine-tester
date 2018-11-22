FROM alpine:3.8

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="docker-alpine-tester" \
  org.label-schema.description="Docker Alpine Tester: to perform network tests, you can use this image in OpenShift" \
  org.label-schema.url="http://andradaprieto.es" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/jandradap/docker-alpine-tester" \
  org.label-schema.vendor="Jorge Andrada Prieto" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0" \
  maintainer="Jorge Andrada Prieto <jandradap@gmail.com>" \
  org.label-schema.docker.cmd="docker run --rm -it --name tester -h tester jorgeandrada/docker-alpine-tester"

RUN apk --update --clean-protected --no-cache add \
  drill \
  htop \
  bind-tools \
  wget \
  curl \
  nmap \
  mariadb-client \
  vim \
  openssl \
  bash \
  jq \
  sudo \
  iputils \
  busybox-extras \
  && rm -rf /var/cache/apk/*

ENV USER_LOGIN="monino"

RUN adduser -D $USER_LOGIN \
  && echo "$USER_LOGIN ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $USER_LOGIN

WORKDIR /home/$USER_LOGIN

ENTRYPOINT ["top", "-b"]
