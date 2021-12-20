FROM debian:stable-slim

SHELL ["/bin/bash", "-ex", "-o", "pipefail", "-c"]

VOLUME /data
WORKDIR /data

ARG J_VERSION

RUN mkdir -p /usr/share/applications /usr/share/icons/hicolor/scalable/apps "/root/j${J_VERSION}-user/temp" \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    gtk-update-icon-cache \
 && curl -LO --fail-with-body "http://www.jsoftware.com/download/j${J_VERSION}/install/j${J_VERSION}_amd64.deb" \
 && dpkg -i "j${J_VERSION}_amd64.deb" \
 && apt-get purge -y curl \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && printf "install'all'\\nexit''" > install.ijs \
 && ijconsole install.ijs \
 && rm "j${J_VERSION}_amd64.deb" install.ijs

ENTRYPOINT ["ijconsole"]
