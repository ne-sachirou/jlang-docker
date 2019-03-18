FROM debian:latest

VOLUME /data
WORKDIR /data

ENV J_VERSION=807

COPY j${J_VERSION}_amd64.deb ./

RUN mkdir -p /usr/share/applications /usr/share/icons/hicolor/scalable/apps /root/j64-${J_VERSION}-user/temp \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    gtk-update-icon-cache \
    libedit2 \
 && dpkg -i j${J_VERSION}_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && printf "install'all'\\nexit''" > install.ijs \
 && ijconsole install.ijs \
 && rm install.ijs

ENTRYPOINT ["ijconsole"]
