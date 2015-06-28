# Pull base image.
FROM debian:sid

EXPOSE 8090

RUN \
  apt-get update && \
  apt-get install -y wget xz-utils python && \
  rm -rf /var/lib/apt/lists/*

RUN wget http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz
RUN tar -xf ffmpeg-release-64bit-static.tar.xz && mv /ffmpeg-2.7.1-64bit-static ffmpeg
WORKDIR /ffmpeg
COPY ffserver.conf /ffmpeg/
COPY control.py /ffmpeg/
CMD ./ffserver -f ffserver.conf & python control.py