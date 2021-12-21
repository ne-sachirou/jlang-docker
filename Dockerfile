FROM debian:stable-slim

SHELL ["/bin/bash", "-eux", "-o", "pipefail", "-c"]

VOLUME /data
WORKDIR /data

ARG J_VERSION

# hadolint ignore=DL3003
RUN mkdir -p /usr/share/applications /usr/share/icons/hicolor/scalable/apps "/root/j${J_VERSION}-user/temp" \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    gtk-update-icon-cache \
 && curl -fLO "http://www.jsoftware.com/download/j${J_VERSION}/install/j${J_VERSION}_linux64.tar.gz" \
 && tar zxf "j${J_VERSION}_linux64.tar.gz" \
 && (cd "j${J_VERSION}/bin" && bash -eux install-usr.sh) \
 && apt-get purge -y curl \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && printf "install'all'\\nexit''" > install.ijs \
 && ijconsole install.ijs \
 && rm -rf "j${J_VERSION}_linux64.tar.gz" "j${J_VERSION}" install.ijs

ENTRYPOINT ["ijconsole"]
