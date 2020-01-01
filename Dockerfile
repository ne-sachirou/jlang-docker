FROM debian:latest

VOLUME /data
WORKDIR /data

ARG J_VERSION

COPY j${J_VERSION}_amd64.deb ./

RUN set -ex \
 && mkdir -p /usr/share/applications /usr/share/icons/hicolor/scalable/apps /root/j64-${J_VERSION}-user/temp \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    gtk-update-icon-cache \
 && dpkg -i j${J_VERSION}_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && printf "install'all'\\nexit''" > install.ijs \
 && ijconsole install.ijs \
 && rm install.ijs

ENTRYPOINT ["ijconsole"]
