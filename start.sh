read -s -p "Web Password:" WEBPASSWORD

ServerIP="$(ifconfig wlan0 | awk '/inet /{print $2}')"
ServerIPv6="$(ifconfig wlan0 | awk '/inet6 /{print $2}' | grep -v fe80)"

# ip -6 addr show
# read -p "ServerIPv6: " ServerIPv6
# ip -4 addr show
# read -p "ServerIPv4: " ServerIP

echo ""
echo "ServerIPv6: ${ServerIPv6}"
echo "ServerIP  : ${ServerIP}"
read -p "Press any key to continue..."

export WEBPASSWORD ServerIPv6 ServerIP
docker-compose up -d
