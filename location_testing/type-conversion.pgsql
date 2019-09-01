select st_srid(nyct2010.geom) from nyct2010 limit 1;
select st_srid(st_point(trips.pickup_longitude, trips.pickup_latitude)) from trips limit 1;
select st_srid(st_setsrid(st_point(trips.pickup_longitude, trips.pickup_latitude), 4326)) from trips limit 1;

select DISTINCT nyct2010.ntaname from nyct2010 ORDER BY nyct2010.ntaname;
select max(nyct2010.gid) from nyct2010;
