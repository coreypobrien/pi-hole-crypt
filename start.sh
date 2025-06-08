#!/usr/bin/env bash

set -eo pipefail

# Error if there isn't a secrets/webpassword file
[ ! -f secrets/webpassword ] && echo "Error: secrets/webpassword file not found!" && exit 1

# Read non-secrets from .settings
[ -f .settings ] && source .settings

# Get the domain
[ -z "$DOMAIN" ] && read -p "Domain:" DOMAIN
# Get the cloudflare email
[ -z "$CLOUDFLARE_EMAIL" ] && read -p "Cloudflare Email:" CLOUDFLARE_EMAIL

# If there isn't a cert in config-certbot/cfg/live/cert.pem, generate one with certbot/dns-cloudflare
if [ ! -f config-certbot/cfg/live/${DOMAIN}/cert.pem ]; then
  echo "No cert.pem found, generating one..."
  mkdir -p config-certbot

  # Make sure to use the test endpoint if we're testing
  [ -n "$TEST" ] && TEST="--dry-run"
  docker run -it --rm \
    -v ./config-certbot:/certbot \
    -v ./secrets:/run/secrets \
    --user "1000:1000" \
    certbot/dns-cloudflare \
      certonly \
        --logs-dir /certbot/logs \
        --work-dir /certbot/tmp \
        --config-dir /certbot/cfg \
        --non-interactive \
        --agree-tos \
        --dns-cloudflare \
        --dns-cloudflare-credentials /run/secrets/certbot-cloudflare.ini \
        --dns-cloudflare-propagation-seconds 30 \
        --email ${CLOUDFLARE_EMAIL} \
        --domains ${DOMAIN} \
        ${TEST}
fi

# Get the server IP
ServerIP="$(ifconfig wlan0 | awk '/inet /{print $2}')"
ServerIPv6="$(ifconfig wlan0 | awk '/inet6 /{print $2}' | grep -v fe80)"

echo ""
echo "ServerIPv6: ${ServerIPv6}"
echo "ServerIP  : ${ServerIP}"
read -p "Press any key to continue..."

export ServerIPv6 ServerIP DOMAIN CLOUDFLARE_EMAIL
docker compose up -d --remove-orphans
