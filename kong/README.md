# KONG

## Before started

Create network

```
docker network create shared_network
```

Start Posgresql

```
docker start postgresql
```

Create database

```
CREATE DATABASE kong OWNER=postgres;
```

## Features

Kong Plugins:
 - https://docs.konghq.com/hub/

API gatway:
 - authentication & authorization: JWT, Basic Auth, ACLs
 - logging
 - caching
 - load balancing
 - routing
 - health check
 - rate limit
 - proxy: L4/L7


Operation:
 - Via API
 - Konga - Kong GUI