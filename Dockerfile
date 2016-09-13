FROM ubuntu:latest

MAINTAINER turtle "turtle@anasit.com"

COPY sources.list /etc/apt/sources.list

RUN \
        # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
        apt-get clean && \
        apt-get update && \
        apt-get install curl && \
        curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
        apt-get install -y nodejs

COPY npmrc ~/.npmrc

RUN \
        npm install -g cnpm && \        
        cnpm install -g cordova ionic && \
        ionic start myApp tabs && \
        apt-get install -y supervisor


RUN mkdir -p /var/log/supervisor


ADD supervisord.conf /etc/supervisord.conf


CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 8100
