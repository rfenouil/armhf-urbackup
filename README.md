# rfenouil/armhf-urbackup

Forked from `n3PH1lim/armhf-urbackup`.

Dockerfile modifications:
- Updated base image
- Updated urBackup verion and dependencies
- Added btrfs-tools

Image must be compiled and run on the arm Device (or pulled from DockerHub).

BTRFS filesystem recommended for backup volume.  
Check logs after starting container, urBackup tests for snapshots and subvolumes ability on startup.

Using BTRFS, if you need to remove something in the backup folder (BE CAREFUL, it contains backups !!!), you might need the command:  
`btrfs subvolume delete filename`  
Because urBackup uses subvolumes on BTRFS.

Should be started with --privileged to get btrfs support.

Tested on Rock64 running OMV (linux 4.4.167-1169-rockchip-ayufan-g3cde5c624c9c).

Command line run example:

docker run -d \
--name Urbackup-Server \
--privileged \
--network=host \
-v PATH_TO_BACKUP_DIR:/URBACKUP_FOLDER/ \
-v /tmp/:/tmp/ \
-v /var/log/:/var/log/ \
-v /var/urbackup/:/var/urbackup/ \
github.com/rfenouil/armhf-urbackup.git


Once image is built/pulled, container can also be started using OMV Docker interface.


