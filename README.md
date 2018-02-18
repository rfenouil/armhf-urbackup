docker run -d \
--name Urbackup-Server \
--network=host \
-v PATH_TO_LOGDIR:/var/log/ \
-v PATH_TO_CONFIG:/var/urbackup/ \
-v PATH_TO_BACKUP_DIR:/media/BACKUP/ \
-v PATH_TO_TEMP_DIR:/tmp/ \
armhf-urbackup:latest
