docker run -d --name=zookeeper -p 2181:2181 confluentinc/cp-zookeeper:latest

docker run -d --name=kafka -p 9092:9092 --link zookeeper:zookeeper \
    -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
    confluentinc/cp-kafka:latest
