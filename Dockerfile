FROM python:3.6-buster

RUN apt-get update && \
    apt-get install -y apt-transport-https default-jre-headless ffmpeg scrot sysstat unzip xvfb apt-utils

RUN groupadd -r chrome && \
    useradd -r -g chrome -G audio,video,users -m chrome
    
RUN wget -qO- https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v0.29.1-linux64.tar.gz | tar xzv -C /usr/local/bin && \
    apt-get install -y firefox-esr && \
    rm -rf /var/lib/apt/lists/*
    
RUN apt-get update && apt-get install -y apt-utils chromium chromium-driver

COPY install-requirements.sh .
