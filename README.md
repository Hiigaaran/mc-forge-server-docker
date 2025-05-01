# mc-forge-server-docker

podman run -d \
  -p 25565:25565 \
  -v $(pwd)/server.properties:/minecraft/server.properties \
  -v $(pwd)/mods:/minecraft/mods \
  --name forge-server \
  mc-forge-server:v1alpha