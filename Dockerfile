FROM python:3.6.8

RUN apt update && \
    apt upgrade -y && \
    apt install -y apt-transport-https default-jre-headless ffmpeg scrot sysstat unzip xvfb && \
    \
    groupadd -r chrome && \
    useradd -r -g chrome -G audio,video chrome && \
    \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt update && \
    apt install -y google-chrome-stable && \
    \
    CHROME_VER=$(google-chrome --version | awk '{print $3}' | awk 'BEGIN{FS=OFS="."} NF--') && \
    CROMEDRIVER_VER=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VER}) && \
    wget -q https://chromedriver.storage.googleapis.com/${CROMEDRIVER_VER}/chromedriver_linux64.zip && \
    unzip -o chromedriver_linux64.zip -d /usr/local/bin && \
    rm chromedriver_linux64.zip && \
    \
    rm -rf /var/lib/apt/lists/*

COPY install-requirements.sh .
