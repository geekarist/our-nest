create extension postgis;

create table lieux (id serial not null, nom text not null, coord Point not null, primary key (id));

insert into lieux (nom, coord)
values 
('Gustave Roussy', '(2.349472300000002,48.7959755)'), 
('Spaces Les Halles', '(2.341928400000029,48.8626868)'), 
('Collines de l''Arche', '(2.236781599999972,48.8932982)'), 
('Valérie', '(2.258250999999973,48.606501)'), 
('Parents Pelé', '(2.499546799999962, 48.717779)');

select * from lieux;
