FROM alpine
MAINTAINER Pavel Litvinenko <gerasim13@gmail.com>

COPY sshd_config /etc/ssh/sshd_config
RUN apk add --update dropbear && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*
RUN rc-update add dropbear && \
    rc-status
RUN touch /run/openrc/softlevel && \
    adduser -D user -h /data/ && \
    dropbear -h

RUN rc-service dropbear start
RUN rc-service dropbear stop

VOLUME ["/data/"]
EXPOSE 22

CMD  ["rc-service", "dropbear"]
