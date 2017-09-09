FROM  openjdk:8-jdk-slim

ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.0.1

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

## Install Scala
## Install sbt
## Piping curl directly in tar
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends curl && \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc && \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install -y sbt && \
  sbt sbtVersion

# Define working directory
WORKDIR /root
