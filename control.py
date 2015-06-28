import re
import time
import os
import urllib2

FFMPEG_CMD = 'ffmpeg -i rtsp://admin:12345@lillis.duckdns.org/h264/ch1/main/av_stream -vcodec flv http://localhost:8090/feed1.ffm'


def is_client_connected(stat):
    m = re.findall(r'stream\.swf', stat)
    return len(m) > 2


def main():
    restreamer_started = False
    while True:
        try:
            data = urllib2.urlopen('http://localhost:8090/stat.html').read()
        except:
            continue
        if is_client_connected(data):
            if not restreamer_started:
                print 'starting ffmpeg'
                os.system(FFMPEG_CMD + ' &')
            restreamer_started = True
        else:
            if restreamer_started:
                os.system('pkill ffmpeg')
                print('killing ffmpeg')
            restreamer_started = False
        time.sleep(1)


if __name__ == "__main__":
    main()
