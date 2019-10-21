
-- Sélection ventes maisons IDF, calcul surface

drop table dvf_cpele;

create table dvf_cpele as
select
	*,
	coalesce(surface_reelle_bati, coalesce(lot1_surface_carrez, 0) + coalesce(lot2_surface_carrez, 0) + coalesce(lot3_surface_carrez, 0) + coalesce(lot4_surface_carrez, 0) + coalesce(lot5_surface_carrez, 0)) as surface
from
	etalab_dvf
where
	nature_mutation = 'Vente'
	and (surface_reelle_bati is not null
	or lot1_surface_carrez is not null)
	and type_local = 'Maison'
	and valeur_fonciere is not null
	and code_departement in ('75',
	'91',
	'92',
	'93',
	'94',
	'95',
	'77',
	'78');

-- Suppression mutations à plusieurs lignes 

delete
from
	dvf_cpele
where
	id_mutation in (
	select
		id_mutation
	from
		(
		select
			id_mutation,
			count(id_mutation)
		from
			dvf_cpele
		group by
			id_mutation) as xx
	where
		count != 1);

-- Prix/m2 par ligne

drop table dvf_cpele_prix_m2;

create table dvf_cpele_prix_m2 as
select
	*,
	valeur_fonciere / surface as prix_m2
from
	dvf_cpele;

select
	prix_m2,
	*
from
	dvf_cpele_prix_m2;

-- Suppression prix absurdes

delete
from
	dvf_cpele_prix_m2
where
	prix_m2 > 40000
	or prix_m2 < 1000;

-- Prix/m2 par ville

drop table dvf_cpele_prix_m2_ville;

create table dvf_cpele_prix_m2_ville as
select
	code_departement,
	code_postal,
	nom_commune,
	count(*),
	median(prix_m2) as prix_m2,
	median(longitude) as longitude,
	median(latitude) as latitude
from
	dvf_cpele_prix_m2
group by
	code_departement,
	code_postal,
	nom_commune;

-- Prix/m2 par dept

select
	code_departement,
	median(prix_m2)
from
	dvf_cpele_prix_m2
group by
	code_departement;

-- Divers

select * from dvf_cpele_prix_m2_ville
where count > 10
order by prix_m2 desc;

-- Colonne position

alter table dvf_cpele
add column position_geo point;

update dvf_cpele 
set position_geo = point(longitude,latitude);

select * from dvf_cpele as dc;

-- Prix/m2 par code insee

drop table dvf_cpele_prix_m2_par_insee;

create table dvf_cpele_prix_m2_par_insee as
select
	code_departement,
	code_postal,
	code_commune,
	nom_commune,
	count(*),
	median(prix_m2) as prix_m2,
	median(longitude) as longitude,
	median(latitude) as latitude
from
	dvf_cpele_prix_m2
group by
	code_departement,
	code_postal,
	code_commune,
	nom_commune;

