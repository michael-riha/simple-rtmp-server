FROM debian:10.3-slim
LABEL Maintainer="Michael Riha <michael.riha@gmail.com>"

#to un tzdata also not active to choose a timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
wget \
procps \
supervisor

COPY conf/rtmp-server.conf /etc/supervisor/conf.d/
COPY scripts /tmp
RUN sh /tmp/install.sh

#for RTMP
EXPOSE 1935/tcp

RUN chmod 755 /tmp/start.sh
#ENTRYPOINT "/bin/bash"

ENTRYPOINT [ "/tmp/start.sh" ]