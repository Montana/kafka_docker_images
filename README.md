# kafka_docker_images
Kafka Docker Images.

## Bash Script

Run the following:

```bash
chmod +x kafka_broker.sh
./kafka_broker.sh
```

## Run Docker Image

```bash
docker build -t kafka_docker_images .
```

## Run Docker Container

Then run the Docker container:

```bash
docker run -d --name zookeeper -p 2181:2181 confluentinc/cp-zookeeper:latest
docker run -d --name kafka -p 9092:9092 --link zookeeper:zookeeper kafka_docker_images
``` 
