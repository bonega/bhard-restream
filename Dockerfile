# Pull base image.
FROM debian:sid

EXPOSE 8090

RUN \
  apt-get update && \
  apt-get install -y wget xz-utils python ffmpeg && \
  rm -rf /var/lib/apt/lists/*

COPY app/ /
CMD ffserver -f /ffserver.conf & python /control.py