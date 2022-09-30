# Postgres 9.6 Dockerized 

## List TODO:
   * Create directory `/var/lib/postgresql/data`
   * Change the superuser for PostgreSQL on `POSTGRES_USER`
   * Change the superuser password for PostgreSQL on `POSTGRES_PASSWORD`
   * Change the database name on `POSTGRES_DB`
   * Change the expose port number on `ports`
   * To start container:
      * `docker-compose up -d`
   * To clean container:
      * `docker-compose down -v`


## Create database

```
CREATE DATABASE db_name OWNER=db_user;
```