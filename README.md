# Kafka Docker Images

This repository provides Docker images for running Kafka, along with ngrok, for exposing Kafka outside your local network for use with Travis CI tunneling via ngrok.

## Features

- Kafka setup in a Docker container.
- ngrok integration for exposing Kafka.
- Customizable and easy to use.

### Installation

1. Clone the repository:

```sh
git clone https://github.com/Montana/kafka_docker_images.git
cd kafka_docker_images
```

2. Build the Docker image:

```sh
docker build -t kafka-ngrok .
```

### Usage

1. Run the Docker container:

```sh
docker run -d --name kafka-ngrok -p 9092:9092 -p 4040:4040 kafka-ngrok
```

2. Access the ngrok dashboard to get the public URL for Kafka by visiting `http://localhost:4040` in your browser.


<br>![output](https://github.com/Montana/kafka_docker_images/assets/20936398/7ad26537-7eb7-4ee8-bdd8-33a6fa3fac8f)</br>
_Flowchart illustrated by Michael Mendy_.

## Dockerfile

The Dockerfile sets up Kafka and ngrok in a single container:

```Dockerfile
FROM confluentinc/cp-kafka:latest

RUN apt-get update && apt-get install -y curl unzip && \
    curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | apt-key add - && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install -y ngrok

COPY ngrok_kafka_start.sh /usr/local/bin/ngrok_kafka_start.sh

RUN chmod +x /usr/local/bin/ngrok_kafka_start.sh

EXPOSE 9092
EXPOSE 4040

CMD ["/usr/local/bin/ngrok_kafka_start.sh"]
```
_Worth noting you can use `node:16-slim` in the `Dockerfile`_.

## Start Script

The `ngrok_kafka_start.sh` script starts Kafka and ngrok:

```bash
#!/bin/bash

/etc/confluent/docker/run &

sleep 20

ngrok http 9092 &

tail -f /dev/null

# Keep the container running. - Michael Mendy. 
```

## Copyright

* Michael Mendy (c) 2024
* Travis CI, GmBH (c) 2024
