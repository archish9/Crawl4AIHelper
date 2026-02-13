FROM unclecode/crawl4ai:latest

USER root

# Fix runtime permission issues for crawl4ai cache
ENV HOME=/home/appuser
ENV CRAWL4AI_HOME=/home/appuser/.crawl4ai

# Create cache dir and set permissions safely (avoiding chown -R on pre-installed binaries)
RUN mkdir -p /home/appuser/.crawl4ai && \
    chown appuser:appuser /home/appuser/.crawl4ai && \
    chmod 777 /home/appuser/.crawl4ai

# Render free tier fixes (dynamic $PORT + no rate limits)
COPY config.yml /app/config.yml
COPY entrypoint.sh /entrypoint.sh

# Ensure appuser can read/modify the config and entrypoint
RUN chown appuser:appuser /app/config.yml /entrypoint.sh /app/supervisord.conf && \
    chmod +x /entrypoint.sh && \
    apt-get update && apt-get install -y sed && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
CMD []