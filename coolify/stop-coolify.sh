#!/bin/bash

# Define paths
COOLIFY_PATH="/data/coolify/source"
ENV_FILE="${COOLIFY_PATH}/.env"
COMPOSE_FILE="${COOLIFY_PATH}/docker-compose.yml"
COMPOSE_PROD_FILE="${COOLIFY_PATH}/docker-compose.prod.yml"
COMPOSE_CUSTOM_FILE="${COOLIFY_PATH}/docker-compose.custom.yml"

# Check if required files exist
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: docker-compose.yml not found at $COMPOSE_FILE"
    exit 1
fi

if [ ! -f "$COMPOSE_PROD_FILE" ]; then
    echo "Error: docker-compose.prod.yml not found at $COMPOSE_PROD_FILE"
    exit 1
fi

# Stop the services
echo "Stopping Coolify services..."
docker compose \
    --env-file "$ENV_FILE" \
    -f "$COMPOSE_FILE" \
    -f "$COMPOSE_PROD_FILE" \
    -f "$COMPOSE_CUSTOM_FILE" \
    down

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Coolify services stopped successfully!"
else
    echo "Error: Failed to stop Coolify services"
    exit 1
fi 