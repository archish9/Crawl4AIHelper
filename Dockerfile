FROM unclecode/crawl4ai:latest

# Render free tier fixes (dynamic $PORT + no rate limits)
COPY config.yml /app/config.yml
COPY entrypoint.sh /entrypoint.sh

# Fix runtime permission issues for crawl4ai cache
ENV HOME=/home/appuser
ENV CRAWL4AI_HOME=/home/appuser/.crawl4ai

RUN mkdir -p /home/appuser/.crawl4ai && \
    chown -R 1000:1000 /home/appuser && \
    chmod -R 777 /home/appuser/.crawl4ai

USER root
RUN chmod +x /entrypoint.sh && \
    apt-get update && apt-get install -y sed && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
CMD []