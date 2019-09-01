SELECT
    trips.id as CabID
    , nyct2010.gid as tract_id
    , point(trips.pickup_longitude, trips.pickup_latitude) AS ThisSpot
    , nyct2010.ntaname AS Hood
FROM
    nyct2010
    , trips
WHERE
    EXTRACT(YEAR FROM trips.pickup_datetime) = 2015
AND
    nyct2010.ntaname IN ('Stuyvesant Town-Cooper Village', 'Gramercy', 'Washington Heights North', 'Chinatown')
AND
    st_within(st_setsrid(st_point(trips.pickup_longitude, trips.pickup_latitude), 4326), nyct2010.geom)
LIMIT 1000;
