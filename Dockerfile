FROM python:3.9-buster

RUN apt-get update && \
    apt-get install -y apt-transport-https default-jre-headless ffmpeg scrot sysstat unzip xvfb apt-utils && \
    apt-get install -y firefox-esr && \
    apt-get install -y apt-utils chromium chromium-driver && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && \
    useradd -r -g chrome -G audio,video,users -m chrome

ADD https://snapshots.mitmproxy.org/8.1.0/mitmproxy-8.1.0-linux.tar.gz /home/chrome/proxy/
RUN cd /home/chrome/proxy && \
    tar xf mitmproxy-8.1.0-linux.tar.gz && \
    chown chrome:chrome -R /home/chrome/proxy && \
    rm mitmproxy mitmweb mitmproxy-8.1.0-linux.tar.gz

# uncomment if necessary to trust certificates
# RUN bash -c "/home/chrome/proxy/mitmdump &" && \
#     sleep 3 
    
# RUN mv /root/.mitmproxy /home/chrome/ && \
#     chown chrome:chrome -R /home/chrome/.mitmproxy && \
#     cp /home/chrome/.mitmproxy/mitmproxy-ca.pem /usr/local/share/ca-certificates && \
#     update-ca-certificates

RUN wget -qO- https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v0.29.1-linux64.tar.gz | tar xzv -C /usr/local/bin
COPY install-requirements.sh .
