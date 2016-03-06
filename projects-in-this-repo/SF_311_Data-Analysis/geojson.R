# Mac OS X users: brew install geos
install.packages(c('spatialEco','sp','rgdal','V8','geojsonio')) # type 'n' when prompted to install from source
require(spatialEco)
require(sp)
require(rgdal)
require(geojsonio)
download.file('https://data.sfgov.org/api/geospatial/bwbp-wk3r?method=export&format=GeoJSON', 'census_tracts.geojson', 'auto')
census_tracts = geojson_read('census_tracts.geojson', what='sp')
plot(census_tracts)
census_tracts@data # view tract number, neighborhood, geoid for each polygon

download.file('https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD', 'calls.csv', 'auto')
calls = read.csv('calls.csv')
require(stringr)
coordinates_match_groups = str_match(calls$Point, "\\((\\d+.\\d+), (-?\\d+.\\d+)\\)$")
lon_lat = coordinates_match_groups[,3:2]
class(lon_lat) = "numeric" # convert strings to numbers
lon_lat[is.na(lon_lat)] = 0 # needed to run next line without errors
lon_lat = SpatialPointsDataFrame(lon_lat, calls, proj4string = census_tracts@proj4string)
calls_census_tracts = point.in.poly(lon_lat, census_tracts)
