FROM openjdk:8-alpine

ARG a4c_version=2.2.0-SM9

RUN apk add --update bash openssl curl python && \
    mkdir -p /var/a4c && \
    cd /var/a4c && \
    addgroup a4c && \
    adduser -D -s /bin/bash -h /var/a4c -g a4c -G a4c a4c && \
    umask 0022 && \
    curl -k -O https://fastconnect.org/maven/service/local/repositories/opensource/content/alien4cloud/alien4cloud-dist/${a4c_version}/alien4cloud-dist-${a4c_version}-dist.tar.gz && \
    tar xvf alien4cloud-dist-${a4c_version}-dist.tar.gz && \
    rm alien4cloud-dist-${a4c_version}-dist.tar.gz && \
    chown -R a4c:a4c /var/a4c && \
    rm -rf /var/cache/apk/*

EXPOSE 8088

USER a4c

ENTRYPOINT cd /var/a4c/alien4cloud && ./alien4cloud.sh

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/alien4cloud/docker-alien4cloud.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$a4c_version \
      org.label-schema.schema-version="1.0.0-rc1"

