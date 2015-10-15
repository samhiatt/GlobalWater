

var ocean=db.water.findOne({'properties.featurecla':'Ocean'});
ocean.geometry.coordinates.forEach(function(polygon){
    polygon.forEach(function(coords){
        db.water.insert({"type" : "Feature","properties" : {"featurecla" : "Ocean"},"geometry":{"type":"MultiLineString","coordinates":[coords]}});
    });
});
db.water.remove({'properties.featurecla':'Ocean','geometry.type':"MultiPolygon"});
db.water.ensureIndex({geometry:'2dsphere'});
