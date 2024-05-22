#!/bin/bash

/etc/confluent/docker/run &

sleep 20

ngrok http 9092 &

tail -f /dev/null

# Keep the container running. - Michael Mendy. 
