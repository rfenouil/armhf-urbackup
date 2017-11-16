#!/bin/bash

if [ -f /opt/minecraft-server/minecraft_server.jar ]
then
	echo "minecraft_server.jar exists"
else
	curl "https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar" -o /opt/minecraft-server/minecraft_server.jar
fi

echo "start minecraft server"
java -Xmx512m -Djava.awt.headless=true -jar /minecraft-server/minecraft_server.jar nogui &

while true; do
	sleep 1000
done
