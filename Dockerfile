FROM python:3.12-slim-bookworm
LABEL maintainer="Jim Clausing, jclausing@isc.sans.edu"
LABEL version="hindsight v2026.01"
LABEL description="Run hindsight.py in a docker container"

WORKDIR /data

RUN apt-get update && apt-get -y install --no-install-recommends git rsync python3-brotli -y \
    && pip3 install pyhindsight \
    && pip3 install git+https://github.com/cclgroupltd/ccl_chromium_reader.git \
    && curl -sSL https://raw.githubusercontent.com/obsidianforensics/hindsight/master/install-js.sh | sh \
    && chmod +x /usr/local/bin/hindsight.py
RUN useradd user

USER user

ENTRYPOINT [ "/usr/local/bin/hindsight.py" ]
CMD [ "--help" ]
