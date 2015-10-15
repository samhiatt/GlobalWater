#!/usr/bin/env bash

[ -f ne_50m_lakes/ne_50m_lakes.geojson ] || ogr2ogr -f GeoJSON ne_50m_lakes/ne_50m_lakes.geojson ne_50m_lakes/ne_50m_lakes.shp &&
[ -f ne_50m_ocean/ne_50m_ocean.geojson ] || ogr2ogr -f GeoJSON ne_50m_ocean/ne_50m_ocean.geojson ne_50m_ocean/ne_50m_ocean.shp &&
echo "db.water.drop();" | mongo topo  &&
jq --compact-output ".features" ne_50m_ocean/ne_50m_ocean.geojson | mongoimport -d topo -c water --type=json --jsonArray &&
jq --compact-output ".features" ne_50m_lakes/ne_50m_lakes.geojson | mongoimport -d topo -c water --type=json --jsonArray &&
(mongo topo init_mongo.mongo.js || echo "Error running init_mongo.mongo.js") \
|| echo "Error importing data."
