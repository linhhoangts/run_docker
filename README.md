# run_docker

## How to run

Step 1: Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

Step 2: Start docker container

```
cd ./mariadb

# to start the container on the background
docker-compose up -d

# to stop and delete the container
docker-compose down

# to check if docker container is running
docker ps

# to stop the container
docker stop <container_name>

# to start the container
docker start <container_name>
```

