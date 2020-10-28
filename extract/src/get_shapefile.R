# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/extract/src/get_shapefile.R

library(here)
library(sf)

INFILE = "https://firstmap.delaware.gov/arcgis/rest/services/Boundaries/DE_SchoolDistricts/MapServer/0/query?where=OBJECTID%3DOBJECTID&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&f=geojson"
OUTFILE = here::here("extract/output/school-districts.geojson")

response = sf::st_read(INFILE)
sf::st_write(response, OUTFILE, delete_dsn = TRUE)
