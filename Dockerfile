FROM openjdk:11-jre-slim

ENV KAFKA_VERSION=2.8.0
ENV SCALA_VERSION=2.13

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} kafka && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

EXPOSE 2181 9092

ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin
ENV ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092

COPY config/zookeeper.properties ${KAFKA_HOME}/config/zookeeper.properties
COPY config/server.properties ${KAFKA_HOME}/config/server.properties

CMD ["sh", "-c", "zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties & kafka-server-start.sh ${KAFKA_HOME}/config/server.properties"]
