FROM debian:latest
ADD j805_amd64.deb /root/j805_amd64.deb
RUN mkdir /usr/share/applications \
 && mkdir -p /usr/share/icons/hicolor/scalable/apps \
 && dpkg -i /root/j805_amd64.deb \
 && apt-get update \
 && apt-get install -y \
    libqt5multimedia5 \
    libqt5webkit5 \
    libqt5websockets5 \
    qt5-default \
    wget \
    xvfb
RUN echo "install'all'\nexit''" > /tmp/install.ijs \
 && ijconsole /tmp/install.ijs \
 && rm /tmp/install.ijs
ENTRYPOINT ijconsole
