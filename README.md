# Pi-Hole Crypt

The Pi-Hole Crypt project is designed to secure your Pi-Hole by providing DNS over TLS (DoT) for encrypted DNS queries from your clients and DNS over HTTPS (DoH) for upstream queries.

## Requirements
- [Docker](https://docs.docker.com/get-docker/)
- [docker-compose](https://docs.docker.com/compose/install/)
- Cloudflare account with a registered domain (for DoT and https support for the pihole web interface)

## Pre-Run Configuration
Before running <code>./start.sh</code> for the first time, ensure that the following settings are configured:
- Create a `secrets/webpassword` file with the password for the Pi-Hole web interface.
- Create a `secrets/certbot-cloudflare.ini` file with your Cloudflare API credentials. This file should contain:
  ```
  dns_cloudflare_api_token = YOUR_CLOUDFLARE_API_TOKEN
  ```
- Optionally, create a `.settings` file with environment variables for `DOMAIN` and `CLOUDFLARE_EMAIL` to set your domain and Cloudflare email address. If this file doesn't exist or you don't have those variables set, the `start.sh` script will prompt you for them.

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/coreypobrien/pi-hole-crypt.git
   cd pi-hole-crypt
   ```

2. **Start the Service**
   Run the startup script to launch the Docker containers:
   ```bash
   ./start.sh
   ```

## Services Included
- **pihole:** DNS filtering and ad blocking service powered by the official Pi-Hole image.
- **cloudflared:** Provide a secure DNS upstream for pihole over HTTPS (DoH) using Cloudflare's DNS service.
- **certbot:** Manages SSL/TLS certificate renewals using Let's Encrypt and Cloudflare DNS.
- **stunnel:** Provides DoT (DNS over TLS) for secure DNS queries
- **cert-combiner:** Combines certificates and keys for use in pihole
- **autoheal:** Automatically restarts unhealthy Docker containers.
