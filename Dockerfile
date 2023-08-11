FROM openjdk:20-jdk AS openjdk
FROM node:18.16 AS node

RUN apt-get update
RUN apt-get install ffmpeg zip -y

# Install OpenJDK and Java Compiler
COPY --from=openjdk /usr/java/openjdk-20 /usr/openjdk
ENV PATH="/usr/openjdk/bin:/usr/openjdk/lib:/usr/openjdk/lib/server:${PATH}"
ENV JAVA_HOME=/usr/openjdk
ENV JAVA_VERSION=20
ENV JDK_VERSION=20
ENV LD_LIBRARY_PATH=/usr/openjdk/lib:/usr/openjdk/lib/server

COPY package.json .
COPY index.js .
COPY index.js.map .
COPY index.ts .
COPY node_modules ./node_modules
COPY imports ./imports

ENTRYPOINT ["node", "index.js"]
