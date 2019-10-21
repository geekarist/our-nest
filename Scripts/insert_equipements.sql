create table bpe18_ensemble_xy ( 
	id serial not null,
	reg text,
	dep text,
	depcom text,
	dciris text,
	an text,
	typequ text,
	lambert_x numeric,
	lambert_y numeric,
	qualite_xy text,
	primary key (id) 
);

copy bpe18_ensemble_xy (reg,dep,depcom,dciris,an,typequ,lambert_x,lambert_y,qualite_xy)
FROM '/Users/christobal/Downloads/bpe18_ensemble_xy_csv/bpe18_ensemble_xy.csv'
delimiter ';'
CSV HEADER;

alter table bpe18_ensemble_xy
add position_geo geometry;

update bpe18_ensemble_xy
set position_geo st_setsrid(
	geometry(point(split_part(lambert_x, ',', 2)::numeric, split_part(lambert_y, ',', 1)::numeric)),
	2154
);

select * from bpe18_ensemble_xy
;

create table varmod_bpe18_ensemble_xy ( id serial not null,
COD_VAR text,
LIB_VAR text,
COD_MOD text,
LIB_MOD text,
TYPE_VAR text,
LONG_VAR text,
primary key (id) );

copy varmod_bpe18_ensemble_xy (COD_VAR,LIB_VAR,COD_MOD,LIB_MOD,TYPE_VAR,LONG_VAR)
FROM '/Users/christobal/Workspaces/our-nest/data/equipements/varmod_bpe18_ensemble_xy.csv'
delimiter ';'
CSV HEADER;

select * from varmod_bpe18_ensemble_xy;

