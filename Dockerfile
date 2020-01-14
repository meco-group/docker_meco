FROM node:8.17.0-alpine

RUN apk add --update --no-cache git bash
#RUN apk upgrade

# GULP
RUN npm install -g gulp && npm link gulp
RUN npm install gulp-sass gulp-autoprefixer gulp-rename gulp-minifier

# HUGO
ENV URL=https://github.com/gohugoio/hugo/releases/download/v0.62.2/hugo_0.62.2_Linux-64bit.tar.gz

ADD ${URL} /tmp/hugo/download.tar.gz
RUN tar -xf /tmp/hugo/download.tar.gz -C /tmp/hugo/
RUN mkdir -p /usr/local/sbin && \
    mv /tmp/hugo/hugo /usr/local/sbin/hugo
RUN rm -rf /tmp/hugo

# cleanup
RUN rm -rf /tmp/hugo && rm -rf /tmp/npm-*

VOLUME ["/src", "/public"]
WORKDIR /src

EXPOSE 1313
