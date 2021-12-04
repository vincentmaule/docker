FROM karsten13/magicmirror:fat

USER root

RUN set -e; \
    apt-get update; \
    apt-get upgrade; \
    apt-get clean; \

USER node