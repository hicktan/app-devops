FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY website/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY config/nginx.conf /etc/nginx/sites-available/default
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY . .

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]