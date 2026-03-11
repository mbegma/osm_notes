--select * from public.planet_osm_polygon where "natural" in ('tree','tree_row','wood')
CREATE TABLE public.osm_pol_natural (
    id serial NOT null,
	osm_id int4 NULL,
	"access" text NULL,
	"addr:housename" text NULL,
	"addr:housenumber" text NULL,
	"addr:interpolation" text NULL,
	admin_level text NULL,
	aerialway text NULL,
	aeroway text NULL,
	amenity text NULL,
	area text NULL,
	barrier text NULL,
	bicycle text NULL,
	brand text NULL,
	bridge text NULL,
	boundary text NULL,
	building text NULL,
	construction text NULL,
	covered text NULL,
	culvert text NULL,
	cutting text NULL,
	denomination text NULL,
	disused text NULL,
	embankment text NULL,
	foot text NULL,
	"generator:source" text NULL,
	harbour text NULL,
	highway text NULL,
	historic text NULL,
	horse text NULL,
	intermittent text NULL,
	junction text NULL,
	landuse text NULL,
	layer text NULL,
	leisure text NULL,
	"lock" text NULL,
	man_made text NULL,
	military text NULL,
	motorcar text NULL,
	"name" text NULL,
	"natural" text NULL,
	office text NULL,
	oneway text NULL,
	"operator" text NULL,
	place text NULL,
	population text NULL,
	power text NULL,
	power_source text NULL,
	public_transport text NULL,
	railway text NULL,
	"ref" text NULL,
	religion text NULL,
	route text NULL,
	service text NULL,
	shop text NULL,
	sport text NULL,
	surface text NULL,
	toll text NULL,
	tourism text NULL,
	"tower:type" text NULL,
	tracktype text NULL,
	tunnel text NULL,
	water text NULL,
	waterway text NULL,
	wetland text NULL,
	width text NULL,
	wood text NULL,
	z_order int4 NULL,
	way_area float4 NULL,
	way geometry NULL
);

CREATE UNIQUE INDEX osm_pol_natural_id_idx ON public.osm_pol_natural (id);
CREATE INDEX osm_pol_natural_osm_id_idx ON public.osm_pol_natural USING btree (osm_id);
CREATE INDEX osm_pol_natural_way_idx ON public.osm_pol_natural USING gist (way);
CREATE INDEX osm_pol_natural_natural_idx ON public.osm_pol_natural USING btree ("natural");
--select * from public.planet_osm_polygon where "natural" in ('tree','tree_row','wood')



INSERT INTO public.osm_pol_natural (osm_id, "access", "addr:housename", "addr:housenumber", "addr:interpolation", admin_level, aerialway, aeroway, amenity, area, barrier, bicycle, brand, bridge, boundary, building, construction, covered, culvert, cutting, denomination, disused, embankment, foot, "generator:source", harbour, highway, historic, horse, intermittent, junction, landuse, layer, leisure, "lock", man_made, military, motorcar, "name", "natural", office, oneway, "operator", place, population, power, power_source, public_transport, railway, "ref", religion, route, service, shop, sport, surface, toll, tourism, "tower:type", tracktype, tunnel, water, waterway, wetland, width, wood, z_order, way_area, way) 
SELECT osm_id, "access", "addr:housename", "addr:housenumber", "addr:interpolation", admin_level, aerialway, aeroway, amenity, area, barrier, bicycle, brand, bridge, boundary, building, construction, covered, culvert, cutting, denomination, disused, embankment, foot, "generator:source", harbour, highway, historic, horse, intermittent, junction, landuse, layer, leisure, "lock", man_made, military, motorcar, "name", "natural", office, oneway, "operator", place, population, power, power_source, public_transport, railway, "ref", religion, route, service, shop, sport, surface, toll, tourism, "tower:type", tracktype, tunnel, water, waterway, wetland, width, wood, z_order, way_area, way 
FROM public.planet_osm_polygon pop
WHERE pop."natural" in ('tree','tree_row','wood');


select count(*) from public.osm_pol_natural opn ;




