#!/bin/sh
set -e

# Make it listen on Render's dynamic $PORT
sed -i "s/port: 11235/port: ${PORT}/g" /app/config.yml
sed -i "s/0.0.0.0:11235/0.0.0.0:${PORT}/g" /app/supervisord.conf

echo "🚀 Crawl4AI starting on port $PORT (Render free tier)"

# If no command is provided, run supervisord
if [ $# -eq 0 ]; then
    exec supervisord -c /app/supervisord.conf
else
    exec "$@"
fi