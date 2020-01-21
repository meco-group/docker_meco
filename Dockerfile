FROM alpine:3.11

RUN apk add --update --no-cache \
        python3 \
        py3-pip \
        git \
        bash \
        make

RUN pip3 install --upgrade pip
RUN pip3 install sphinx recommonmark pyyaml

VOLUME ["/src", "/build"]
WORKDIR /src
