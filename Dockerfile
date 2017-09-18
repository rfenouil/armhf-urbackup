FROM resin/rpi-raspbian:latest

MAINTAINER d3fault <14540322+n3PH1lim@users.noreply.github.com>

RUN [ "cross-build-start" ]

RUN sudo apt-get update && \
sudo apt-get install oracle-java8-installer && \
sudo apt-get install oracle-java8-set-default

# Create directory, downloader JD" and start JD2 for the initial update and creation of config files.
RUN \
	mkdir -p /opt/JDownloader/ &&\
	wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar &&\
	java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar


COPY startJD2.sh /opt/JDownloader/
RUN chmod +x /opt/JDownloader/startJD2.sh


# Run this when the container is started
CMD /opt/JDownloader/startJD2.sh


RUN [ "cross-build-end" ]
