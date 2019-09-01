SELECT
    CabsInHoods.CabID AS CabID
    , CabsInHoods.NumVisits AS NumVisits
    , CabsInHoods.hood AS Hood
    , point(fake_cabs.longitude, fake_cabs.latitude) AS Spotted
FROM
(
    SELECT
    count(cabs.id) AS NumVisits
    , cabs.cabid AS CabID
    -- , nyct2010.gid as tract_id
    , nyct2010.ntaname AS Hood
    -- , point(cabs.longitude, cabs.latitude) AS ThisSpot
FROM
    nyct2010
    , fake_cabs AS cabs
WHERE
    nyct2010.ntaname IN ('Stuyvesant Town-Cooper Village', 'Gramercy', 'Washington Heights North', 'Chinatown')
AND
    st_within(st_setsrid(st_point(cabs.longitude, cabs.latitude), 4326), nyct2010.geom)
GROUP BY
    cabs.cabid, nyct2010.ntaname
) AS CabsInHoods, fake_cabs
WHERE
    CabsInHoods.CabID = fake_cabs.cabid
LIMIT 1000;
