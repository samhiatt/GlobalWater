#!/usr/bin/env bash
HOST="localhost:27017"
DB="topo"
if [ ! -z "$1" ]
  then
    DB=$1
    if [ ! -z "$2" ]; then
      HOST=$2
    fi;
fi
echo "HOST:$HOST DB:$DB"
[ -f ne_50m_lakes/ne_50m_lakes.geojson ] || ogr2ogr -f GeoJSON ne_50m_lakes/ne_50m_lakes.geojson ne_50m_lakes/ne_50m_lakes.shp &&
[ -f ne_50m_ocean/ne_50m_ocean.geojson ] || ogr2ogr -f GeoJSON ne_50m_ocean/ne_50m_ocean.geojson ne_50m_ocean/ne_50m_ocean.shp &&
echo "db.topo.water.drop();" | mongo $HOST/$DB  &&
jq --compact-output ".features" ne_50m_ocean/ne_50m_ocean.geojson | mongoimport -d $DB -c topo.water --type=json --jsonArray &&
jq --compact-output ".features" ne_50m_lakes/ne_50m_lakes.geojson | mongoimport -d $DB -c topo.water --type=json --jsonArray &&
(mongo $HOST/$DB init_mongo.mongo.js || echo "Error running init_mongo.mongo.js") \
|| echo "Error importing data."
