# Postgres 9.6 Dockerized for Replication

## Master Postgres Replication
   * Create directory `/var/lib/postgresql/data`
   * Change the superuser for PostgreSQL on `POSTGRES_USER`
   * Change the superuser password for PostgreSQL on `POSTGRES_PASSWORD`
   * To start MASTER container:
      * `docker-compose -f docker-compose-master.yml up -d`
   * To clean MASTER container:
      * `docker-compose -f docker-compose-master.yml down -v`
## Slave Postgres Replication
   * Create directory `/var/lib/postgresql/data`
   * Change the superuser for PostgreSQL on `POSTGRES_USER`
   * Change the superuser password for PostgreSQL on `POSTGRES_PASSWORD`
   * Change Master-node's IP on `REPLICATE_FROM`
   * To start SLAVE container:
      * `docker-compose -f docker-compose-slave.yml up -d`
   * To clean SLAVE container:
      * `docker-compose -f docker-compose-slave.yml down -v`
