--          
-- 
CREATE TABLE osm_cut.osm_ukr_vegetation_pol (
    id serial NOT null,
	osm_id int8 NULL, 
	"name" text NULL,
	"natural" text NULL,
	landuse text NULL, 
	barrier text null,
	place text NULL, 
	way_area float4 NULL,
	way geometry NULL
);


CREATE UNIQUE INDEX osm_ukr_vegetation_pol_id_idx ON osm_cut.osm_ukr_vegetation_pol(id);
CREATE INDEX osm_ukr_vegetation_pol_osm_id_idx ON osm_cut.osm_ukr_vegetation_pol USING btree (osm_id);
CREATE INDEX osm_ukr_vegetation_pol_way_idx ON osm_cut.osm_ukr_vegetation_pol USING gist (way);
CREATE INDEX osm_ukr_vegetation_pol_natural_idx ON osm_cut.osm_ukr_vegetation_pol USING btree ("natural");
CREATE INDEX osm_ukr_vegetation_pol_landuse_idx ON osm_cut.osm_ukr_vegetation_pol USING btree (landuse);


insert into osm_cut.osm_ukr_vegetation_pol(osm_id, "name", "natural", landuse, barrier, place, way_area, way) 
select osm_id, "name", "natural", landuse, barrier, place, way_area, way 
from osm_data_ukr.public.planet_osm_polygon pop  
where "natural" in ('tree', 'tree_row', 'wood', 'heath', 'scrub', 'wetland', 'grassland', 'meadow', 'fell') or 
landuse in ('forest', 'orchard', 'vineyard', 'grass', 'greenfield', 'village_green', 'recreation_ground') or 
barrier in ('hedge')

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_vegetation_pol ouvp ;
-- 899 190

-- 
CREATE TABLE osm_cut.osm_ukr_vegetation_lin (
    id serial NOT null,
	osm_id int8 NULL, 
	"name" text NULL,
	"natural" text NULL,
	landuse text NULL, 
	barrier text null,
	place text NULL, 
	way_area float4 NULL,
	way geometry NULL
);

CREATE UNIQUE INDEX osm_ukr_vegetation_lin_id_idx ON osm_cut.osm_ukr_vegetation_lin(id);
CREATE INDEX osm_ukr_vegetation_lin_osm_id_idx ON osm_cut.osm_ukr_vegetation_lin USING btree (osm_id);
CREATE INDEX osm_ukr_vegetation_lin_way_idx ON osm_cut.osm_ukr_vegetation_lin USING gist (way);
CREATE INDEX osm_ukr_vegetation_lin_natural_idx ON osm_cut.osm_ukr_vegetation_lin USING btree ("natural");
CREATE INDEX osm_ukr_vegetation_lin_landuse_idx ON osm_cut.osm_ukr_vegetation_lin USING btree (landuse);

insert into osm_cut.osm_ukr_vegetation_lin(osm_id, "name", "natural", landuse, barrier, place, way_area, way) 
select osm_id, "name", "natural", landuse, barrier, place, way_area, way 
from osm_data_ukr.public.planet_osm_line   
where "natural" in ('tree', 'tree_row', 'wood', 'heath', 'scrub', 'wetland', 'grassland', 'meadow', 'fell') or 
landuse in ('forest', 'orchard', 'vineyard', 'grass', 'greenfield', 'village_green', 'recreation_ground') or 
barrier in ('hedge')

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_vegetation_lin;
-- 30 618

--    
CREATE TABLE osm_cut.osm_ukr_vegetation_pnt (
    id serial NOT null,
	osm_id int8 NULL, 
	"name" text NULL,
	"natural" text NULL,
	landuse text NULL, 
	barrier text null,
	place text NULL, 
	way geometry NULL
);

CREATE UNIQUE INDEX osm_ukr_vegetation_pnt_id_idx ON osm_cut.osm_ukr_vegetation_pnt(id);
CREATE INDEX osm_ukr_vegetation_pnt_osm_id_idx ON osm_cut.osm_ukr_vegetation_pnt USING btree (osm_id);
CREATE INDEX osm_ukr_vegetation_pnt_way_idx ON osm_cut.osm_ukr_vegetation_pnt USING gist (way);
CREATE INDEX osm_ukr_vegetation_pnt_natural_idx ON osm_cut.osm_ukr_vegetation_pnt USING btree ("natural");
CREATE INDEX osm_ukr_vegetation_pnt_landuse_idx ON osm_cut.osm_ukr_vegetation_pnt USING btree (landuse);

insert into osm_cut.osm_ukr_vegetation_pnt(osm_id, "name", "natural", landuse, barrier, place, way) 
select osm_id, "name", "natural", landuse, barrier, place, way 
from osm_data_ukr.public.planet_osm_point   
where "natural" in ('tree', 'tree_row', 'wood', 'heath', 'scrub', 'wetland', 'grassland', 'meadow', 'fell') or 
landuse in ('forest', 'orchard', 'vineyard', 'grass', 'greenfield', 'village_green', 'recreation_ground') or 
barrier in ('hedge')

select count(osm_id) from osm_data_ukr.osm_cut.osm_ukr_vegetation_pnt;
-- 109 000


