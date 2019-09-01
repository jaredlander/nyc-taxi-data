SELECT
    cabs.id as ID
    , cabs.cabid AS CabID
    , nyct2010.gid as tract_id
    , point(cabs.longitude, cabs.latitude) AS ThisSpot
FROM
    nyct2010
    , fake_cabs AS cabs
WHERE
    nyct2010.ntaname IN ('Stuyvesant Town-Cooper Village', 'Gramercy', 'Washington Heights North', 'Chinatown')
AND
    st_within(st_setsrid(st_point(cabs.longitude, cabs.latitude), 4326), nyct2010.geom)
LIMIT 1000;
