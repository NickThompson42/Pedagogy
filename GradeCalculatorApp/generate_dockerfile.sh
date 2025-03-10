#!/usr/bin/env bash
#
# generate_dockerfile.sh
#
# Usage:
#   chmod +x generate_dockerfile.sh
#   ./generate_dockerfile.sh
#
# This script writes a Dockerfile to the current directory.

cat <<EOF > Dockerfile
# Use a slim Python 3.9 base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy only requirements first (for better cache efficiency)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Expose port 5000 (adjust if needed)
EXPOSE 5000

# Default command to run when starting the container
CMD ["python", "run.py"]
EOF

echo "Dockerfile generated successfully."
