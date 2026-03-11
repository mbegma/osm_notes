# OSM Notes
---    
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

