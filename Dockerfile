FROM debian:13.0-slim

RUN apt-get update --quiet --quiet \
  && apt-get upgrade --quiet --quiet

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install --quiet --quiet --yes \
  --no-install-recommends --no-install-suggests \
  ca-certificates \
  postfix \
  libsasl2-modules \
  && apt-get --quiet --quiet clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root
WORKDIR /root

# Remove default configs
RUN rm -f /etc/postfix/master.cf /etc/postfix/main.cf

COPY entrypoint.sh ./

VOLUME ["/var/log", "/var/spool/postfix"]
EXPOSE 25/TCP
ENTRYPOINT ["./entrypoint.sh"]
CMD ["postfix", "-v", "start-fg"]
