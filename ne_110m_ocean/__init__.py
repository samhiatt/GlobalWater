from osgeo import ogr
import os

path = os.path.join(os.path.dirname(__file__),"ne_110m_ocean.shp")
ds=ogr.Open(path)

layer=ds.GetLayerByIndex(0)

