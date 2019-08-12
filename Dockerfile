# Base system is the Raspian ARM image from Resin
FROM balenalib/rpi-raspbian:stretch   

# Default port of UrBackup server
EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Prepare UrBackup dependencies
RUN apt-get update && \
    apt-get install -y  btrfs-tools \
                        libcrypto++-dev \
                        libcurl3-nss \
                        libfuse2 \
                        libnspr4 \
                        libnss3 \
                        lsb-release \
                        sqlite3 \
                        wget && \
    rm -rf /var/lib/apt/lists/*

# Download UrBasckup package and install
ENV VERSION_URBACKUP 2.3.8
RUN wget https://hndl.urbackup.org/Server/${VERSION_URBACKUP}/urbackup-server_${VERSION_URBACKUP}_armhf.deb -O download && \
    dpkg -i download && \
    rm download

# Set the backup folder path in default config file
RUN echo  "/URBACKUP_FOLDER" > /etc/urbackup/backupfolder

# Mount root folder for backups
VOLUME /URBACKUP_FOLDER

# Mount folder for log file
VOLUME /var/log/

# Mount config folder. If empty, default files will be created.
# Keeping this folder separate allows to migrate the server with complaints by the clients
VOLUME /var/urbackup/

# If set up, used for backup temp files
VOLUME /tmp/

# Default port of UrBackup server
EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623

ENTRYPOINT ["/usr/bin/urbackupsrv"]

# Default operation is run, adding -u root solves permission issues with mounted volumes
CMD ["run", "-u root"]


