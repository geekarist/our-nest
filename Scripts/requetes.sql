
-- Villes à moins de 5 km d'une gare
 select
	communes.code_postal,
	communes.nom_commune,
	etalab_gares.nom_gare,
	etalab_gares.ligne
from
	(
	select
		*
	from
		communes
	where
		code_postal ilike '91%'
		or code_postal ilike '78%'
		or code_postal ilike '77%') as communes
join etalab_gares on
	st_distancesphere(geometry(geo_point_position),
	geometry(communes.coord_position)) < 5000;

select
	count(distinct(code_postal))
from
	(
	select
		*
	from
		communes
	where
		code_postal ilike '91%'
		or code_postal ilike '78%'
		or code_postal ilike '77%') as communes
join etalab_gares on
	st_distancesphere(geometry(geo_point_position),
	geometry(communes.coord_position)) < 5000;
	
select
	count(communes.code_postal)
from
	(
	select
		*
	from
		communes
	where
		code_postal ilike '91%'
		or code_postal ilike '78%'
		or code_postal ilike '77%') as communes;