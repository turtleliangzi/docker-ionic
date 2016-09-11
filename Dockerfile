FROM ubuntu:16.04

MAINTAINER turtle "turtle@anasit.com"

RUN \
        # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
        apt-get update && \
        apt-get install -y git && \
        git clone https://github.com/tj/n.git && \
        cd n && \
        apt-get install -y make && \
        make && \
        apt-get install -y curl && \
        n stable && \
        apt-get install -y vim && \
        apt-get install -y supervisor


RUN mkdir -p /var/log/supervisor

ADD npmrc ~/.npmrc

RUN npm install -g ionic@beta

RUN cd ~
RUN ionic start myApp --v2


ADD supervisord.conf /etc/supervisord.conf

# 配置nginx


CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 8100
