# Usa una imagen de Java 17, necesaria para versiones recientes de Minecraft + Forge
FROM docker.io/openjdk:17-jdk-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /minecraft

# Variables de entorno (puedes personalizarlas)
ENV FORGE_VERSION=1.20.1-47.1.44 \
    FORGE_INSTALLER=forge-1.20.1-47.1.44-installer.jar \
    EULA=true

# Instala utilidades necesarias
RUN apt-get update && apt-get install -y wget && \
    apt-get clean

# Descarga el instalador de Forge
RUN wget -O ${FORGE_INSTALLER} https://maven.minecraftforge.net/net/minecraftforge/forge/${FORGE_VERSION}/${FORGE_INSTALLER}

# Ejecuta el instalador de Forge en modo servidor
RUN java -jar ${FORGE_INSTALLER} --installServer && \
    rm ${FORGE_INSTALLER}

# Acepta el EULA automáticamente
RUN echo "eula=${EULA}" > eula.txt

# Copiar archivo de configuración si existe en el contexto
COPY server.properties /minecraft/server.properties

RUN ls -la

# Expone el puerto por defecto de Minecraft
EXPOSE 25565

# Crea un volumen para los mods
VOLUME ["/minecraft/mods"]

# Comando por defecto para iniciar el servidor
#CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "forge-1.20.1-47.1.44.jar", "nogui"]
CMD ["sh", "run.sh"]
