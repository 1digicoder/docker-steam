FROM ubuntu:xenial

MAINTAINER Robert Elsner (digicoder@gmail.com)

ENV DEBIAN_FRONTEND=noninteractive

#copy source list that has steamcmd on it
COPY sources.list /etc/apt/sources.list.d/

#get utilities for downloading/managing console servers
RUN apt-get update -q && apt-get install -y \
    htop \
    screen \
    wget \
    unzip

#install updates and steam
RUN dpkg --add-architecture i386 && \
    apt-get update -q && \
    apt-get install -yqq ca-certificates && \
    echo debconf steam/question select I AGREE | debconf-set-selections && \
    apt-get install -yqq steamcmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#create steam user
RUN groupadd -r steam && \
    useradd -r -g steam -m steam

USER steam

RUN mkdir ~/games
VOLUME /home/steam/games

ONBUILD ENTRYPOINT []

