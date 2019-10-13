drop table etalab_dvf;

create table etalab_dvf (
    id_mutation text,
    date_mutation date,
    numero_disposition text,
    nature_mutation text,
    valeur_fonciere numeric,
    adresse_numero numeric,
    adresse_suffixe text,
    adresse_nom_voie text,
    adresse_code_voie text,
    code_postal text,
    code_commune text,
    nom_commune text,
    code_departement text,
    ancien_code_commune text,
    ancien_nom_commune text,
    id_parcelle text,
    ancien_id_parcelle text,
    numero_volume text,
    lot1_numero text,
    lot1_surface_carrez numeric,
    lot2_numero text,
    lot2_surface_carrez numeric,
    lot3_numero text,
    lot3_surface_carrez numeric,
    lot4_numero text,
    lot4_surface_carrez numeric,
    lot5_numero text,
    lot5_surface_carrez numeric,
    nombre_lots numeric,
    code_type_local text,
    type_local text,
    surface_reelle_bati numeric,
    nombre_pieces_principales numeric,
    code_nature_culture text,
    nature_culture text,
    code_nature_culture_speciale text,
    nature_culture_speciale text,
    surface_terrain numeric,
    longitude numeric,
    latitude numeric
);

copy etalab_dvf (id_mutation,date_mutation,numero_disposition,nature_mutation,valeur_fonciere,adresse_numero,adresse_suffixe,adresse_nom_voie,adresse_code_voie,code_postal,code_commune,nom_commune,code_departement,ancien_code_commune,ancien_nom_commune,id_parcelle,ancien_id_parcelle,numero_volume,lot1_numero,lot1_surface_carrez,lot2_numero,lot2_surface_carrez,lot3_numero,lot3_surface_carrez,lot4_numero,lot4_surface_carrez,lot5_numero,lot5_surface_carrez,nombre_lots,code_type_local,type_local,surface_reelle_bati,nombre_pieces_principales,code_nature_culture,nature_culture,code_nature_culture_speciale,nature_culture_speciale,surface_terrain,longitude,latitude)
FROM '/Users/christobal/Workspaces/our-nest/full.csv'
delimiter ','
CSV HEADER;