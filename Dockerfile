FROM python:3.11-slim

# Install rclone for R2 sync
RUN apt-get update && apt-get install -y rclone && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

CMD python visualization/serve.py
