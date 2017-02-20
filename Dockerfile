FROM debian:latest
ADD j805_amd64.deb /root/j805_amd64.deb
ADD install.sh install.sh
RUN ./install.sh && rm install.sh
VOLUME /data
WORKDIR /data
ENTRYPOINT ["ijconsole"]
