# Traefik Starter

A minimal, production-ready Traefik stack using Docker Compose. This setup is designed for easy replication and deployment on any server.

## Features
- Traefik v3 reverse proxy
- Automatic HTTPS with Let's Encrypt
- HTTP Basic Auth for dashboard
- Sablier plugin integration
- Watchtower for automatic updates

## Directory Structure
```
traefik-starter/
├── docker-compose.yml
├── dynamic-config.yml
├── .env.example
└── README.md
```

## Prerequisites
- Docker & Docker Compose installed
- Pre-existing Docker networks: `traefik-public` and `coolify` (or adjust as needed)

## Setup
1. **Clone this repository:**
   ```sh
   git clone <your-repo-url> traefik-starter
   cd traefik-starter
   ```
2. **Create your `.env` file:**
   Copy `.env.example` to `.env` and fill in your values:
   ```sh
   cp .env.example .env
   # Edit .env with your credentials and domain
   ```
   - `USERNAME`: Dashboard login username
   - `HASHED_PASSWORD`: Bcrypt hash of your password (generate with `htpasswd -nbB <user> <password>`)
   - `DOMAIN`: Your domain (e.g., example.com)
   - `ACME_EMAIL`: Email for Let's Encrypt notifications

3. **Start the stack:**
   ```sh
   docker compose up -d
   ```

4. **Access the Traefik dashboard:**
   - URL: `https://traefik.<your-domain>`
   - Login with the credentials from your `.env` file

## Notes
- The stack expects the `traefik-public` and `coolify` Docker networks to exist. Create them if needed:
  ```sh
  docker network create traefik-public
  docker network create coolify
  ```
- Certificates are stored in a Docker volume for persistence.
- The `dynamic-config.yml` file configures the Sablier plugin and middleware.

## Replication
To replicate on another server:
1. Copy this directory to the new server.
2. Adjust `.env` as needed.
3. Ensure required Docker networks exist.
4. Run `docker compose up -d`.

## Security
- Do **not** commit your real `.env` file with secrets to public repositories.
- Use strong, unique passwords for dashboard access.

## License
MIT 