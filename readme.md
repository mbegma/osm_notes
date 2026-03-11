# OSM Notes
---    
## Инструкции по развертыванию и созданию данных, а также примеры запросов на создание и обновление данных    
   
### Данные OSM   
  
http://download.geofabrik.de/  
(https://wiki.openstreetmap.org/wiki/RU:Planet.osm)  

---   
### Инструменты для импорта   
   
### Osm2pgsql  
  
https://wiki.openstreetmap.org/wiki/RU:Osm2pgsql  

### Osmosis

https://wiki.openstreetmap.org/wiki/RU:Osmosis   

---   

## Импорт данных  
##### Источники:  
- https://habr.com/ru/post/467043/  
- https://wiki.openstreetmap.org/wiki/RU:Osm2pgsql  
---   

1. Скачиваем файл .pbf на нужную территорию с http://download.geofabrik.de/  
2. Создаем БД в Postgresql:  
```sql
CREATE DATABASE osm_data;
```  
3. Добавляем к базе необходимые расширения:  
```sql
CREATE EXTENSION postgis;  
CREATE EXTENSION hstore;  
```
> Расширение **postgis** «подключает» к БД собственно модуль по работе с геоданными (напомню, необходимо установить сам Postgis).  
> Расширение **hstore** предназначено для работы с наборами ключ/значение, т.к. много информации будет содержаться в OSM-тегах.  

4. Инструмент импортирования данных **osm2pgsql**  
формируем командный файл .bat, в котором указываем все необходимые параметры (путь к инструменту, имя БД, путь к файлу со стилем, путь к файлу с данными).   
Пример :  
  
```
D:\Projects\OSM\osm2pgsql-bin\osm2pgsql.exe -d osm_data -U postgres -W -H localhost -P 5432 -s -S D:\Projects\OSM\osm2pgsql-bin\default.style D:\Projects\OSM\PBF_SOURCE\russia-latest.osm.pbf
```

5. Запускаем файл .bat на выполнение. В зависимости от объема исходных данных время импорта может быть различным.

---    

## Краткая инструкция
#### Первоначальная загрузка:    
1. Создаем tablespace
2. Создаем пользователя
3. Создаем базу, указываем tablespace (1) и пользователя-владельца (2)   
3. Добавляем в базу расширения: `hstore`, `postgis`
4. Скачиваем сырые данные OSM
5. Правим `\*.bat` файл, в котором прописываем базу, куда экспортировать, путь к сырым данным, файл стиля
6. Запускаем `\*.bat` файл
7. Ждем окончания загрузки ...
    
#### Обновление данных:    
1. Скачиваем данные, которые необходимо обновить   
2. Запускаем *.bat файл, существующие данные обновятся автоматически   
3. Ждем окончания обновления...
     
## Создание пользователя и схемы

```
Server [localhost]:  
Database [postgres]:  
Port [5432]:  
Username [postgres]:  
psql (12.2)  
ПРЕДУПРЕЖДЕНИЕ: Кодовая страница консоли (866) отличается от основной  
                страницы Windows (1251).  
                8-битовые (русские) символы могут отображаться некорректно.  
                Подробнее об этом смотрите документацию psql, раздел  
                "Notes for Windows users".   
Введите "help", чтобы получить справку.  
  
postgres=#  

postgres=# CREATE ROLE gis LOGIN PASSWORD 'gis' NOINHERIT CREATEDB;   
CREATE ROLE   
   
postgres=# \c geo_names   
Вы подключены к базе данных "geo_names" как пользователь "postgres".   
   
geo_names=# CREATE SCHEMA gis AUTHORIZATION gis;   
CREATE SCHEMA   
   
geo_names=# GRANT USAGE ON SCHEMA gis TO PUBLIC;   
GRANT   

geo_names=# GRANT SELECT,INSERT,UPDATE,DELETE ON public.Geometry_columns TO gis   
geo_names-#   
   
```

### Примеры sql запросов на создание, выборку, вставку данных    
#### Создание таблицы железнодорожных платформ  

Создание таблицы **railway_pltfs_pol** в базе **osm_data** в схеме **osm_cut** и     
копирование в нее выбранных данных из базы со всеми данными OSM  

```sql
-- создание таблицы
CREATE TABLE osm_data.osm_cut.railway_pltfs_pol(
    id serial NOT null,
	osm_id int8 NULL,
	area text NULL,
	construction text NULL,
	covered text NULL,
	highway text NULL,
	layer text NULL,
	"name" text NULL,
	public_transport text NULL,
	railway text NULL,
	service text NULL,
	surface text NULL,
	tunnel text NULL,
	z_order int4 NULL,
	way_area float4 NULL,
	way geometry null
	);
	
-- вставка данных 
INSERT INTO osm_data.osm_cut.railway_pltfs_pol (osm_id, area, construction, covered, highway, layer, "name", public_transport, railway, service, surface, tunnel, z_order, way_area, way) 
SELECT osm_id, area, construction, covered, highway, layer, "name", public_transport, railway, service, surface, tunnel, z_order, way_area, way 
FROM public.planet_osm_polygon pop
WHERE pop.area = 'yes' and 
pop.public_transport = 'platform' and 
pop.railway = 'platform' ;

-- создание индексов
CREATE UNIQUE INDEX railway_pltfs_pol_id_idx ON osm_data.osm_cut.railway_pltfs_pol (id);
CREATE INDEX railway_pltfs_pol_osm_id_idx ON osm_data.osm_cut.railway_pltfs_pol USING btree (osm_id);
CREATE INDEX railway_pltfs_pol_way_idx ON osm_data.osm_cut.railway_pltfs_pol USING gist (way);
   

```

### пример создания таблицы и вставка в нее данных    
```sql
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
```

### данные vegetation
```sql
-- vegetation
select osm_id, "name", "natural", landuse, barrier, way_area, way 
from planet_osm_polygon pop 
where 
pop."natural" in ('tree', 'tree_row', 'wood', 'heath', 'scrub', 'wetland', 'grassland', 'meadow', 'fell') or 
pop.landuse in ('forest', 'orchard', 'vineyard', 'grass', 'greenfield', 'village_green', 'recreation_ground') or 
pop.barrier in ('hedge')

INSERT INTO osm_data.osm_cut.vegetation (osm_id, "access", "addr:housename", "addr:housenumber", "addr:interpolation", admin_level, aerialway, aeroway, amenity, area, barrier, bicycle, brand, bridge, boundary, building, construction, covered, culvert, cutting, denomination, disused, embankment, foot, "generator:source", harbour, highway, historic, horse, intermittent, junction, landuse, layer, leisure, "lock", man_made, military, motorcar, "name", "natural", office, oneway, "operator", place, population, power, power_source, public_transport, railway, "ref", religion, route, service, shop, sport, surface, toll, tourism, "tower:type", tracktype, tunnel, water, waterway, wetland, width, wood, z_order, way_area, way) 
SELECT osm_id, "access", "addr:housename", "addr:housenumber", "addr:interpolation", admin_level, aerialway, aeroway, amenity, area, barrier, bicycle, brand, bridge, boundary, building, construction, covered, culvert, cutting, denomination, disused, embankment, foot, "generator:source", harbour, highway, historic, horse, intermittent, junction, landuse, layer, leisure, "lock", man_made, military, motorcar, "name", "natural", office, oneway, "operator", place, population, power, power_source, public_transport, railway, "ref", religion, route, service, shop, sport, surface, toll, tourism, "tower:type", tracktype, tunnel, water, waterway, wetland, width, wood, z_order, way_area, way 
FROM osm_data.public.planet_osm_polygon pop
where pop."natural" in ('tree', 'tree_row', 'wood', 'heath', 'scrub', 'wetland', 'grassland', 'meadow', 'fell') or 
pop.landuse in ('forest', 'orchard', 'vineyard', 'grass', 'greenfield', 'village_green', 'recreation_ground') or 
pop.barrier in ('hedge');
```
