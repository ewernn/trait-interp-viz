FROM python:3.11-slim

RUN apt-get update && apt-get install -y rclone && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

CMD bash -c 'mkdir -p ~/.config/rclone && \
    printf "[r2]\ntype = s3\nprovider = Cloudflare\naccess_key_id = %s\nsecret_access_key = %s\nendpoint = %s\n" "$R2_ACCESS_KEY_ID" "$R2_SECRET_ACCESS_KEY" "$R2_ENDPOINT" > ~/.config/rclone/rclone.conf && \
    rclone sync r2:trait-interp-bucket/experiments/gemma-2-2b-it/ /app/experiments/gemma-2-2b-it/ --progress && \
    python visualization/serve.py'
