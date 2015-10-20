

var ocean=db.topo.water.findOne({'properties.featurecla':'Ocean'});
ocean.geometry.coordinates.forEach(function(polygon){
    polygon.forEach(function(coords){
        db.topo.water.insert({"type" : "Feature","properties" : {"featurecla" : "Ocean"},"geometry":{"type":"MultiLineString","coordinates":[coords]}});
    });
});
db.topo.water.remove({'properties.featurecla':'Ocean','geometry.type':"MultiPolygon"});
db.topo.water.ensureIndex({geometry:'2dsphere'});
