FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11-utils \
    libnss3 \
    libnspr4 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-shm0 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libxkbcommon0 \
    libglib2.0-0 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgl1-mesa-dri \
    libegl1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libcairo2 \
    libwayland-client0 \
    libasound2t64 \
    fonts-liberation \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN python -m patchright install chromium --with-deps

COPY . .
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
