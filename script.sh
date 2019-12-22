#!/bin/bash

docker build . --tag postgress-anyvision:v1.0
docker run --name anyvision_db -e POSTGRES_PASSWORD=password -d postgress-anyvision:v1.0

# docker exec postgres connect to db and create table missing

docker exec -t anyvision_db pg_dump -c -U postgres | gzip > anyvision_dump_`date +%Y%m%d`.sql.gz
ls -t db dumps/ | tail -n +11 | xargs rm --
rsync -avz --delete db_dumps user@x.x.x.x:/destination
