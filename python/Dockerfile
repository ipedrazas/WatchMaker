FROM alpine:3.4
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

RUN apk add --update \
      python \
      py-pip \
      bash \
       && \
      pip install flask requests

COPY . /app


CMD [ "python", "/app/watchmaker.py" ]
