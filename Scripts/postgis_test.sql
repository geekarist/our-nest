create database postgis_test;

create extension postgis;

create table pointsTable (id serial not null, name varchar(255) not null, location Point not null, primary key (id));

insert into pointstable (name, location)
values ('IGR', '(2.3484482999999727,48.79425879999999)'), ('Spaces Les Halles', '(2.341928400000029,48.8626868)');

insert into pointstable (name, location)
values ('Karma', '(2.715916,48.397083)'), ('Sophia', '(7.047210,43.622350)');

select *
from pointstable;

select ST_DistanceSphere(geometry(a.location), geometry(b.location))
from pointstable a, pointstable b
where a.id = 3
and b.id = 4;