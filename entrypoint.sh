#!/bin/sh
set -e

# Make it listen on Render's dynamic $PORT
sed -i "s/port: 11235/port: ${PORT}/g" /app/config.yml

echo "🚀 Crawl4AI starting on port $PORT (Render free tier)"

# Run the official server
exec "$@"