FROM alpine:3.7
MAINTAINER ErnestGWilsonII@gmail.com

RUN apk add --no-cache --virtual .build-deps autoconf automake g++ git libtool make mariadb-dev \
  && cd /tmp \
  && git clone https://github.com/akopytov/sysbench.git \
  && cd sysbench \
  && ./autogen.sh \
  && ./configure --disable-shared \
  && make install clean\
  && rm -Rf /tmp/sysbench \
  && apk del .build-deps \
  && apk add --no-cache libgcc mariadb-client-libs

ENTRYPOINT ["/usr/local/bin/sysbench"]

