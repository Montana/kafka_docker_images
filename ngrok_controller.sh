docker stop kafka

NGROK_URL=$(./ngrok tcp 9092 | grep -o "tcp://0.tcp.ngrok.io:[0-9]*")
ADVERTISED_LISTENERS="advertised.listeners=PLAINTEXT://${NGROK_URL:6}"

sed -i "/^advertised.listeners=/c\\$ADVERTISED_LISTENERS" config/server.properties

docker start kafka
