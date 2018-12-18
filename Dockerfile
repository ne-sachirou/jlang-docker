FROM debian:latest

VOLUME /data
WORKDIR /data

COPY j807_amd64.deb ./

RUN mkdir -p /usr/share/applications /usr/share/icons/hicolor/scalable/apps /root/j64-807-user/temp \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    gtk-update-icon-cache \
    libedit2 \
 && dpkg -i j807_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && printf "install'all'\\nexit''" > install.ijs \
 && ijconsole install.ijs \
 && rm install.ijs

ENTRYPOINT ["ijconsole"]
