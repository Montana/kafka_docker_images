# kafka_docker_images
Kafka Docker Images.

## Run Docker Image

```bash
docker build -t kafka_docker_images .
```

Then run the Docker container:

```bash
docker run -d --name kafka-container -p 2181:2181 -p 9092:9092 kafka_docker_images
``` 
