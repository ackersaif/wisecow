# Use slim Python image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy wisecow.sh into container
COPY wisecow.sh .

# Install dependencies: bash, fortune-mod, fortunes-min, cowsay, netcat
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        fortune-mod \
        fortunes-min \
        cowsay \
        netcat-openbsd && \
    chmod +x wisecow.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose the server port
EXPOSE 4499

# Command to run the app
CMD ["./wisecow.sh"]
