select * from communes;

alter table communes
add coord_position point;

update communes
set coord_position = point(split_part(coordonnees_gps, ',', 2)::numeric, split_part(coordonnees_gps, ',', 1)::numeric);

select 
	*, 
	point(
		split_part(coordonnees_gps, ',', 2)::numeric,
		split_part(coordonnees_gps, ',', 1)::numeric 
	) as coord_position
from communes;

alter table etalab_gares
add geo_point_position point;

update etalab_gares
set geo_point_position = point(geo_point_lon,geo_point_lat);
