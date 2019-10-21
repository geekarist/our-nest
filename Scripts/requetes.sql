
-- Villes à moins de 5 km d'une gare

select distinct 
	communes.code_postal,
	communes.code_insee,
	communes.nom_commune,
	etalab_gares.nom_gare,
	ST_SetSRID(geometry(communes.coord_position), 4326)
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
	geometry(communes.coord_position)) < 5000
order by code_postal, code_insee, nom_commune;

select
	count(distinct(code_insee))
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
	distinct communes.code_insee, nom_commune
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
	st_distancesphere(geometry(geo_point_position), geometry(communes.coord_position)) < 5000;

select
	count(communes.code_insee)
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

select distinct on (code_postal, code_insee, nom_commune)
	communes.nom_commune,
	communes.code_postal,
	communes.code_insee,
	etalab_gares.nom_gare,
	st_distancesphere(
		geometry(geo_point_position),
		geometry(communes.coord_position)
	) as distance_gare_m,
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
	prix_m2,
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
join dvf_cpele_prix_m2_ville prix_m2 on prix_m2.code_postal = communes.code_postal and prix_m2.prix_m2 < 3500 and prix_m2.count > 10
order by code_postal, code_insee, nom_commune, distance_gare_m
;

select * from lieux;

-- Villes avec boulangerie, boucherie, banque, bureau de poste, pharmacie, épicerie

select * from bpe18_ensemble_xy;
select * from varmod_bpe18_ensemble_xy where lib_mod ilike '%charcut%';

drop table nb_commerces_par_commune;
create table nb_commerces_par_commune as (
select
communes.code_postal, communes.code_insee, communes.nom_commune, varmode_bpe18.lib_mod, count (varmode_bpe18.lib_mod)
from bpe18_ensemble_xy bpe18
join varmod_bpe18_ensemble_xy varmode_bpe18 on varmode_bpe18.cod_var = 'TYPEQU' and varmode_bpe18.cod_mod = bpe18.typequ
join communes on communes.code_insee = bpe18.depcom
where bpe18.dep = '91'
and lib_mod in ('Boulangerie', 'Boucherie charcuterie', 'Banque, Caisse d''Épargne', 'Bureau de poste', 'Pharmacie', 'Épicerie')
group by communes.code_postal, communes.code_insee, nom_commune, lib_mod
);

update nb_commerces_par_commune
set lib_mod = replace(lib_mod, ' d''Épargne', '');

select * from nb_commerces_par_commune order by nom_commune;

select * from (
select code_postal, code_insee, nom_commune, count(lib_mod) as nombre_par_type, array_agg(lib_mod)
from nb_commerces_par_commune
group by code_postal, code_insee, nom_commune
order by nombre_par_type desc
) as communes_avec_tous_commerces
where nombre_par_type = 1;