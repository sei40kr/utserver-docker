FROM debian:7

MAINTAINER sei40kr <sei40kr@gmail.com>

USER root

ADD utserver.conf /usr/local/utserver/utserver.conf
ADD http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 /usr/local/utserver/utserver.tgz

VOLUME /var/local/utserver/autoload
VOLUME /var/local/utserver/data
VOLUME /var/local/utserver/settings

EXPOSE 8080
EXPOSE 6881
EXPOSE 6881/udp

WORKDIR /var/local/utserver/

RUN apt-get update -q && \
    apt-get install -q openssl ca-certificates wget && \
    apt-get clean -q && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN tar -xzf utserver.tgz --strip-components=1 && \
    rm -f utserver.tgz && \
    chmod +x utserver && \
    mkdir -p autoload data settings

ENTRYPOINT ["/var/local/utserver/utserver", "-configfile", "/var/local/utserver/utserver.conf", "-settingspath", "/var/local/utserver/settings/"]
