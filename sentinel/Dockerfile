# Redis Sentinel [1 master, 2 slaves, 3 sentinels]
# With supervisord for multiple processes management

# Note: this image should only be used in development and test environment
# Don't use it in production environment since all redis master/slaves/sentinels 
# are running on the same local host

# Links to default config files of redis, sentinel and supervisord:
# http://download.redis.io/redis-stable/redis.conf
# http://download.redis.io/redis-stable/sentinel.conf
# https://raw.githubusercontent.com/Supervisor/supervisor/master/supervisor/skel/sample.conf

FROM redis:4.0.1-alpine

LABEL author="quang@trustingsocial.com"

RUN apk add --no-cache supervisor

WORKDIR /etc/redis

COPY supervisord.conf supervisord.conf
COPY master.conf master.conf
COPY slave.conf slave1.conf
COPY slave.conf slave2.conf
COPY sentinel.conf sentinel1.conf
COPY sentinel.conf sentinel2.conf
COPY sentinel.conf sentinel3.conf
COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
