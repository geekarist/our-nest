DROP TABLE etalab_gares;

create table etalab_gares (
    geo_point text,
    geo_shape text,
    objectid numeric,
    id_ref_zdl numeric,
    gares_id numeric,
    nom_gare text,
    nomlong text,
    nom_iv text,
    num_mod numeric,
    mode_ text,
    fer boolean,
    train boolean,
    rer boolean,
    metro boolean,
    tramway boolean,
    navette boolean,
    val boolean,
    terfer text,
    tertrain text,
    terrer text,
    termetro text,
    tertram text,
    ternavette text,
    terval text,
    idrefliga text,
    idrefligc text,
    ligne text,
    cod_ligf numeric,
    ligne_code text,
    indice_lig text,
    reseau text,
    res_com text,
    cod_resf numeric,
    res_stif numeric,
    exploitant text,
    num_psr numeric,
    idf boolean,
    principal boolean,
    x numeric,
    y numeric	
);

copy etalab_gares (geo_point,geo_shape,objectid,id_ref_zdl,gares_id,nom_gare,nomlong,nom_iv,num_mod,mode_,fer,train,rer,metro,tramway,navette,val,terfer,tertrain,terrer,termetro,tertram,ternavette,terval,idrefliga,idrefligc,ligne,cod_ligf,ligne_code,indice_lig,reseau,res_com,cod_resf,res_stif,exploitant,num_psr,idf,principal,x,y)
FROM '/Users/christobal/Workspaces/our-nest/emplacement-des-gares-idf.csv'
delimiter ';'
CSV HEADER;

alter table etalab_gares 
add column geo_point_lat numeric,
add column geo_point_lon numeric;

update etalab_gares
set 
geo_point_lat = split_part(geo_point, ',', 1)::numeric, 
geo_point_lon = split_part(geo_point, ',', 2)::numeric;

alter table etalab_gares
add geo_point_position point;

update etalab_gares
set geo_point_position = point(geo_point_lon,geo_point_lat);

select * from etalab_gares;
