#!/bin/bash

# Starting the PostgreSQL with delay for letting the container to deploy
docker run --name postgress-anyvision -e POSTGRES_PASSWORD=password -d postgres && sleep 5
# Getting inside the container and creating anyViosion DB
docker exec -i postgress-anyvision psql -U postgres -c "create database anyVision"
# Getting inside the container, using anyVision DB 
docker exec -i postgress-anyvision psql -U postgres -d anyvision -c "CREATE TABLE anyvison_table (id int, some_row text);"
# Backing up the DB with Format of YYYYMMDD-Minutes
docker exec -t anyvision_db pg_dump -c -U postgres | gzip > db_dumps/anyvision_dump_`date +%Y%m%d-%M`.sql.gz
# Keeping a max of 10 archives and deleting the 11th (and so on) archive
cd db_dumps && ls -t  | tail -n +11 | xargs rm --
# Rsyncying with delete flags which deleting from dest directory if they do not exist in source
rsync -avz --delete db_dumps user@x.x.x.x:/destination
# Stopping the container
docker stop postgress-anyvision && docker rm postgress-anyvision