read -s -p "Web Password:" WEBPASSWORD
ip -6 addr show
read -p "ServerIPv6: " ServerIPv6
ip -4 addr show
read -p "ServerIPv4: " ServerIP

docker-compose up -d
