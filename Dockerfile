FROM openjdk:15.0.2-oracle

ARG a4c_version=3.3.0
ARG dist=premium-dist

RUN groupadd a4c && \
    useradd -s /bin/bash -d /opt/a4c -g a4c -G a4c a4c && \
    umask 0022 && \
    cd /opt/a4c && \
    curl -v -k -O https://www.portaildulibre.fr/nexus/repository/opensource-releases/alien4cloud/alien4cloud-${dist}/${a4c_version}/alien4cloud-${dist}-${a4c_version}-dist.tar.gz && \
    tar xvf alien4cloud-${dist}-${a4c_version}-dist.tar.gz && \
    rm alien4cloud-${dist}-${a4c_version}-dist.tar.gz && \
    chown -R a4c:a4c /opt/a4c

EXPOSE 8088

USER a4c

ENTRYPOINT cd /opt/a4c/alien4cloud && ./alien4cloud.sh

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/alien4cloud/docker-alien4cloud.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$a4c_version \
      org.label-schema.schema-version="1.0.0-rc1"
