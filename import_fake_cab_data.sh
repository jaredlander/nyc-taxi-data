#!/bin/bash

# delete old data
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "DELETE FROM fake_cabs;"

fake_cab_schema="(id,cabid,longitude,latitude)"
cat data/fake_cab_info.csv | psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "COPY fake_cabs ${fake_cab_schema} FROM stdin CSV HEADER;"

psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "CREATE INDEX ON fake_cabs USING BRIN (longitude, latitude) WITH (pages_per_range = 32);"
