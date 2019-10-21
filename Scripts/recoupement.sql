-- Commerces

create table nb_commerces_par_commune as
select code_postal, code_insee, nom_commune, count(lib_mod) as nombre_par_type, array_agg(lib_mod)
from commerces_par_commune
group by code_postal, code_insee, nom_commune
order by nombre_par_type desc
;

select * from dvf_cpele_prix_m2;

select valeur_fonciere / surface_reelle_bati, * from etalab_dvf where nom_commune ilike '%lardy%' and surface_reelle_bati is not null and type_local = 'Maison';

-- ...

select distinct on (code_postal, code_insee, nom_commune)
	communes.nom_commune,
	communes.code_postal,
	communes.code_insee,
	prix_m2,
	etalab_gares.nom_gare,
	st_distancesphere(
		geometry(geo_point_position),
		geometry(communes.coord_position)
	) as distance_gare_m,
	commerces.nombre_par_type, 
	commerces.array_agg,
	st_distancesphere(
		geometry(lieux_gr.coord),
		geometry(communes.coord_position)
	) as distance_gr,
	st_distancesphere(
		geometry(lieux_val.coord),
		geometry(communes.coord_position)
	) as distance_val,
	st_distancesphere(
		geometry(lieux_yer.coord),
		geometry(communes.coord_position)
	) as distance_yer,
	ST_SetSRID(geometry(communes.coord_position), 4326)
from
	(
	select
		*
	from
		communes
	where
		code_postal ilike '91%') as communes
join etalab_gares on
	st_distancesphere(
		geometry(geo_point_position),
		geometry(communes.coord_position)
	) < 5000
join lieux lieux_gr on lieux_gr.nom = 'Gustave Roussy'
join lieux lieux_val on lieux_val.nom = 'Valérie'
join lieux lieux_yer on lieux_yer.nom = 'Parents Pelé'
join dvf_cpele_prix_m2_par_insee prix_m2 on prix_m2.code_commune = communes.code_insee and prix_m2.count > 10
join nb_commerces_par_commune commerces on communes.code_insee = commerces.code_insee
order by code_postal, code_insee, nom_commune, distance_gare_m
;