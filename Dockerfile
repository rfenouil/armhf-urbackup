# Base system is the Raspian ARM image from Resin
FROM   resin/rpi-raspbian

MAINTAINER d3fault <14540322+n3PH1lim@users.noreply.github.com>

RUN [ "cross-build-start" ]

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive


# Get system up to date to start with.
RUN    apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common


# The special trick here is to download and install the Oracle Java 8 installer from Launchpad.net
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get --yes update


# Make sure the Oracle Java 8 license is pre-accepted, and install Java 8
RUN    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
       echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
       apt-get --yes install curl oracle-java8-installer ; apt-get clean

RUN \
	mkdir -p /opt/JDownloader/ &&\
	wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar &&\
	java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar


COPY startJD2.sh /opt/JDownloader/
RUN chmod +x /opt/JDownloader/startJD2.sh


# Run this when the container is started
CMD /opt/JDownloader/startJD2.sh


RUN [ "cross-build-end" ]
