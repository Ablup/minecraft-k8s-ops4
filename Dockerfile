FROM itzg/minecraft-server:java17

ENV MOTD="Abram Gallup's Server"
ENV EULA="TRUE"

# Expose the Minecraft port
EXPOSE 25565
