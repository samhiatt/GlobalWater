# Global Water Database
Vector data files and utilities for importing into mongodb.

## Data sources
http://www.naturalearthdata.com/downloads/
http://www.naturalearthdata.com/downloads/50m-physical-vectors/

## Dependencies
* gdal (ogr2ogr)
* mongodb
* jq

## Installation
``` brew install gdal mongodb jq ```  
``` cd GlobalWater ```  
``` sh import_data_to_mongodb.sh ```  

## Example queries
##### Find water within 10km of 122.4W, 37.59N:  
` db.water.find({geometry:{$near:{$geometry: {type : "Point" ,coordinates: [  -122.4, 37.59  ]},$maxDistance: 10000}}},{properties:1}) `
