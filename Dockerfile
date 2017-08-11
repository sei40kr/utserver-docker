FROM debian:7

MAINTAINER Seong Yong-ju <sei40kr@gmail.com>

ADD utserver.conf /usr/local/utserver/utserver.conf
ADD http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 /usr/local/utserver/utserver.tgz

VOLUME /var/local/utserver/autoload
VOLUME /var/local/utserver/data
VOLUME /var/local/utserver/settings

EXPOSE 8080
EXPOSE 6881
EXPOSE 6881/udp

WORKDIR /var/local/utserver/

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssl ca-certificates wget && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN tar -xzf utserver.tgz --strip-components=1 && \
    rm -f utserver.tgz && \
    chmod +x utserver && \
    mkdir -p autoload data settings

ENTRYPOINT ["/var/local/utserver/utserver", "-configfile", "/var/local/utserver/utserver.conf", "-settingspath", "/var/local/utserver/settings/"]
