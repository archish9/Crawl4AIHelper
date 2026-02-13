FROM unclecode/crawl4ai:latest

# Render free tier fixes (dynamic $PORT + no rate limits)
COPY config.yml /app/config.yml
COPY entrypoint.sh /entrypoint.sh

USER root
RUN chmod +x /entrypoint.sh && \
    apt-get update && apt-get install -y sed && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
CMD []