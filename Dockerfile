FROM ubuntu:latest

MAINTAINER turtle "turtle@anasit.com"

COPY sources.list /etc/apt/sources.list

RUN \
        # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
        apt-get clean && \
        apt-get update && \
        apt-get install -y curl && \
        apt-get install -y npm && \
        npm install -g n && \
        n stable

COPY npmrc ~/.npmrc

RUN \
        npm install -g cnpm --registry=https://registry.npm.taobao.org && \
        cnpm install -g cordova ionic


WORKDIR /root/myApp

CMD ["ionic", "serve", "--port", "8100", "--livereload-port", "35729", "--all", "--no-browser"]

# Expose ports.
EXPOSE 8100 35729

#ANDROID
#JAVA
ENV DEBIAN_FRONTEND noninteractive
#install python-software-properties (so you can do add-apt-repository)
RUN apt-get update && apt-get install -y -q python-software-properties software-properties-common && apt-get clean

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get -y install oracle-java7-installer && apt-get clean

#ANDROID STUFF
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect ant wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 qemu-kvm kmod && apt-get clean

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools

RUN chmod 755 /opt/tools/android-accept-licenses.sh
ENV PATH ${PATH}:/opt/tools

RUN echo ANDROID_HOME="${ANDROID_HOME}" >> /etc/environment

RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,tools,build-tools-23,android-23,addon-google_apis_x86-google-23,extra-android-support,extra-android-m2repository,extra-google-m2repository,sys-img-x86-android-23 --proxy-host mirrors.neusoft.edu.cn --proxy-port 80 -s"]

