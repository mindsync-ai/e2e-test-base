#!/bin/bash

sed -i '/#/d' requirements.txt && \
pip3 install --no-cache-dir -r requirements.txt && \
pip3 freeze > requirements.installed && \
cat requirements.installed && \
diff requirements.txt requirements.installed
