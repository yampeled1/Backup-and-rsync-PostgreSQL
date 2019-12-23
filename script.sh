#!/bin/bash

random="$((1 + RANDOM % 99))"
cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 1
docker run --name postgress-anyvision -e POSTGRES_PASSWORD=password -d postgres && sleep 5
docker exec -i postgress-anyvision psql -U postgres -c "create database anyVision"
docker exec -i postgress-anyvision psql -U postgres -d anyvision -c "CREATE TABLE anyvison_table (id int, some_row text);"
docker exec -t anyvision_db pg_dump -c -U postgres | gzip > db_dumps/anyvision_dump"$random"_`date +%Y%m%d`.sql.gz
cd db_dumps && ls -t  | tail -n +11 | xargs rm --
#rsync -avz --delete db_dumps user@x.x.x.x:/destination
docker stop postgress-anyvision && docker rm postgress-anyvision