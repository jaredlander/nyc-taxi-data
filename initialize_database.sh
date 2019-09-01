#!/bin/bash

createdb -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data

psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -f setup_files/create_nyc_taxi_schema.sql

shp2pgsql -s 2263:4326 /home/shapes/taxi_zones/taxi_zones.shp | psql -d nyc-taxi-data -U docker
psql -U docker nyc-taxi-data -c "CREATE INDEX ON taxi_zones USING gist (geom);"
psql -U docker nyc-taxi-data -c "CREATE INDEX ON taxi_zones (locationid);"
psql -U docker nyc-taxi-data -c "VACUUM ANALYZE taxi_zones;"

shp2pgsql -s 2263:4326 /home/transhapes/nyct2010_15b/nyct2010.shp | psql -U docker -d nyc-taxi-data
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -f setup_files/add_newark_airport.sql
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "CREATE INDEX ON nyct2010 USING gist (geom);"
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "CREATE INDEX ON nyct2010 (ntacode);"
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "VACUUM ANALYZE nyct2010;"

psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -f setup_files/add_tract_to_zone_mapping.sql

cat data/fhv_bases.csv | psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "COPY fhv_bases FROM stdin WITH CSV HEADER;"
weather_schema="station_id, station_name, date, average_wind_speed, precipitation, snowfall, snow_depth, max_temperature, min_temperature"
cat data/central_park_weather.csv | psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "COPY central_park_weather_observations (${weather_schema}) FROM stdin WITH CSV HEADER;"
psql -h 172.27.168.233 -p 5434 -U docker nyc-taxi-data -c "UPDATE central_park_weather_observations SET average_wind_speed = NULL WHERE average_wind_speed = -9999;"
