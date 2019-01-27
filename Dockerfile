FROM alpine
MAINTAINER Julian Godesa <julian.godesa@googlemail.com>
LABEL description='Drone plugin to release docker image to heroku packaged on alpine linux'

ADD plugin.sh /bin/
RUN chmod +x /bin/plugin.sh
RUN apk -Uuv add docker curl bash ca-certificates
ENTRYPOINT /bin/plugin.sh