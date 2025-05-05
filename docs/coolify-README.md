# Coolify Manual Installation & Usage Guide

This guide explains how to manually install and configure Coolify, including how to use the `DOMAIN` environment variable in your custom Docker Compose setup. It references the official Coolify documentation for further details.

---

## What is Coolify?
Coolify is a self-hosted, open-source platform for deploying and managing applications, databases, and services using Docker. It provides a user-friendly dashboard and supports a wide range of stacks and integrations.

Official docs: [Coolify Installation Guide](https://coolify.io/docs/get-started/installation#manual-installation)

---

## Prerequisites
- **Docker** (version 24+) and **Docker Compose** installed
- A fresh server (VPS, VM, or bare metal) with at least 2 CPU cores, 2GB RAM, and 30GB storage
- SSH access to your server
- A domain name you control (for HTTPS and Traefik integration)

---

## Quick Start
1. **Prepare your server:**
   - Ensure Docker and curl are installed.
   - Log in as root (recommended for installation).
2. **Create required directories:**
   ```sh
   mkdir -p /data/coolify/{source,ssh,applications,databases,backups,services,proxy,webhooks-during-maintenance}
   mkdir -p /data/coolify/ssh/{keys,mux}
   mkdir -p /data/coolify/proxy/dynamic
   ```
3. **Download Coolify files:**
   ```sh
   curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.yml -o /data/coolify/source/docker-compose.yml
   curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.prod.yml -o /data/coolify/source/docker-compose.prod.yml
   curl -fsSL https://cdn.coollabs.io/coolify/.env.production -o /data/coolify/source/.env
   curl -fsSL https://cdn.coollabs.io/coolify/upgrade.sh -o /data/coolify/source/upgrade.sh
   ```
   **Copy the custom Docker Compose file:**
   ```sh
   cp ./coolify/docker-compose.custom.yml /data/coolify/source/docker-compose.custom.yml
   ```
4. **Set permissions:**
   ```sh
   chown -R 9999:root /data/coolify
   chmod -R 700 /data/coolify
   ```
5. **Edit your .env file:**
   - Update `/data/coolify/source/.env` with secure random values for secrets and keys (see [official docs](https://coolify.io/docs/get-started/installation#manual-installation)).
   - Set `DOMAIN=yourdomain.com` to control all service URLs.
6. **Create Docker networks:**
   ```sh
   docker network create --attachable coolify
   docker network create --attachable traefik-public
   ```
7. **Start Coolify:**
   ```sh
   docker compose --env-file /data/coolify/source/.env -f /data/coolify/source/docker-compose.yml -f /data/coolify/source/docker-compose.prod.yml up -d --pull always --remove-orphans --force-recreate
   ```
   
   **Or, use the provided management scripts:**
   
   From the project root, you can start or stop Coolify using:
   ```sh
   ./coolify/start-coolify.sh   # To start Coolify
   ./coolify/stop-coolify.sh    # To stop Coolify
   ```
   These scripts automatically use all required compose files, including your custom overrides.
8. **Access Coolify:**
   - Visit `http://<your-server-ip>:8000` in your browser.
   - Immediately create your admin account to secure your instance.

---

## How Domain Configuration Works
All domain-related rules in the Docker Compose and Coolify files use the `DOMAIN` variable from your `.env` file. Change your domain in `.env` to update all service URLs, including Traefik and Coolify subdomains.

**Example label:**
```yaml
- "traefik.http.routers.coolify-http.rule=Host(`coolify.${DOMAIN?Variable not set}`)"
```

---

## Troubleshooting & FAQ
- **Q: Can't access Coolify dashboard?**
  - Check that your DNS points to your server and the correct ports are open.
- **Q: Docker network errors?**
  - Ensure `coolify` and `traefik-public` networks exist (`docker network ls`).
- **Q: Permission errors?**
  - Make sure you set the correct permissions on `/data/coolify`.
- **Q: How do I update Coolify?**
  - Run the upgrade script or pull new images and restart the stack.
- **Q: How do I connect Coolify with Traefik?**
  - Make sure both use the same Docker networks and the `DOMAIN` variable is set consistently.

---

## References
- [Coolify Manual Installation Docs](https://coolify.io/docs/get-started/installation#manual-installation)
- [Coolify Quick Install Script](https://coolify.io/docs/get-started/installation)
- [Coolify Docker Compose Reference](https://cdn.coollabs.io/coolify/docker-compose.yml)

For more details, troubleshooting, and advanced configuration, see the [Coolify documentation](https://coolify.io/docs/). 