--           

-- 

create table osm_cut.osm_ukr_boundary_pol (
    id serial NOT null,
	osm_id int8 NULL, 
	admin_level text null, 
	boundary text NULL,
	"name" text NULL,
	"name:ru" text NULL,
	"name:uk" text NULL,
	official_name text NULL,
	int_name text NULL, 
	short_name text null,
	place text NULL, 
	timezone text null,
	population text NULL,
	"ref" text NULL,
	"ref:ru" text NULL,
	"ref:en" text NULL,
	way_area float4 NULL,
	way geometry NULL
);

create unique index osm_ukr_boundary_pol_id_idx on osm_cut.osm_ukr_boundary_pol(id);
create index osm_ukr_boundary_pol_osm_id_idx on osm_cut.osm_ukr_boundary_pol using btree (osm_id);
create index osm_ukr_boundary_pol_way_idx on osm_cut.osm_ukr_boundary_pol using gist (way);
create index osm_ukr_boundary_pol_admin_level_idx on osm_cut.osm_ukr_boundary_pol using btree ("admin_level");

grant all on table osm_cut.osm_ukr_boundary_pol to osm_ukr;
-- GRANT ALL ON SEQUENCE osm_cut.osm_ukr_boundary_pol_id_seq TO osm_ukr;

insert into osm_cut.osm_ukr_boundary_pol(
osm_id, admin_level, boundary, 
"name", "name:ru", "name:uk", official_name, int_name, short_name, 
place, timezone, population, "ref", way_area, way) 
select 
	osm_id, admin_level, boundary, "name", "name:ru", "name:uk", official_name, int_name, short_name, 
	place, timezone, population, "ref", way_area, way 
from osm_data_ukr.public.planet_osm_polygon pop  
where boundary = 'administrative' and admin_level in ('2', '4', '6', '7', '8', '9');  

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_boundary_pol;
-- 13 242

-- 

create table osm_cut.osm_ukr_boundary_lin (
    id serial NOT null,
	osm_id int8 NULL, 
	admin_level text null, 
	boundary text NULL,
	"name" text NULL,
	"name:ru" text NULL,
	"name:uk" text NULL,
	official_name text NULL,
	int_name text NULL, 
	short_name text null,
	place text NULL, 
	timezone text null,
	population text NULL,
	"ref" text NULL,
	"ref:ru" text NULL,
	"ref:en" text NULL,
	way_area float4 NULL,
	way geometry NULL
);

create unique index osm_ukr_boundary_lin_id_idx on osm_cut.osm_ukr_boundary_lin(id);
create index osm_ukr_boundary_lin_osm_id_idx on osm_cut.osm_ukr_boundary_lin using btree (osm_id);
create index osm_ukr_boundary_lin_way_idx on osm_cut.osm_ukr_boundary_lin using gist (way);
create index osm_ukr_boundary_lin_admin_level_idx on osm_cut.osm_ukr_boundary_lin using btree ("admin_level");

grant all on table osm_cut.osm_ukr_boundary_lin to osm_ukr;
-- GRANT ALL ON SEQUENCE osm_cut.osm_ukr_boundary_pol_id_seq TO osm_ukr;

insert into osm_cut.osm_ukr_boundary_lin(
osm_id, admin_level, boundary, 
"name", "name:ru", "name:uk", official_name, int_name, short_name, 
place, timezone, population, "ref", way_area, way) 
select 
	osm_id, admin_level, boundary, "name", "name:ru", "name:uk", official_name, int_name, short_name, 
	place, timezone, population, "ref", way_area, way 
from osm_data_ukr.public.planet_osm_line pop  
where boundary = 'administrative' and admin_level in ('2', '4', '6', '7', '8', '9');  

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_boundary_lin;
-- 25 708

-- 

create table osm_cut.osm_ukr_boundary_pnt (
    id serial NOT null,
	osm_id int8 NULL, 
	admin_level text null, 
	boundary text NULL,
	"name" text NULL,
	"name:ru" text NULL,
	"name:uk" text NULL,
	official_name text NULL,
	int_name text NULL, 
	short_name text null,
	place text NULL, 
	timezone text null,
	population text NULL,
	"ref" text NULL,
	"ref:ru" text NULL,
	"ref:en" text NULL,
	way geometry NULL
);

create unique index osm_ukr_boundary_pnt_id_idx on osm_cut.osm_ukr_boundary_pnt(id);
create index osm_ukr_boundary_pnt_osm_id_idx on osm_cut.osm_ukr_boundary_pnt using btree (osm_id);
create index osm_ukr_boundary_pnt_way_idx on osm_cut.osm_ukr_boundary_pnt using gist (way);
create index osm_ukr_boundary_pnt_admin_level_idx on osm_cut.osm_ukr_boundary_pnt using btree ("admin_level");

grant all on table osm_cut.osm_ukr_boundary_pnt to osm_ukr;

insert into osm_cut.osm_ukr_boundary_pnt(
osm_id, admin_level, boundary, 
"name", "name:ru", "name:uk", official_name, int_name, short_name, 
place, timezone, population, "ref", way) 
select 
	osm_id, admin_level, boundary, "name", "name:ru", "name:uk", official_name, int_name, short_name, 
	place, timezone, population, "ref", way 
from osm_data_ukr.public.planet_osm_point pop  
where boundary = 'administrative' and admin_level in ('2', '4', '6', '7', '8', '9');  

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_boundary_pnt;
-- 2




