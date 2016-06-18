## This script, by Jeff Lam, grabs the Census tract polygons, provided by the City, that define
## each of the City's neighborhoods. Then, it checks the 311 case coordinates to see which
## Census tract and neighborhood the City's data office would consider each case being
## within.

## Please note #1: Some necessary external files have been commented out, so that anyone who
## wishes to use this script isn't immediately bogged down with large file downloads.


## Install and load necessary packages.
# Mac OS X users: brew install geos
# install.packages(c('spatialEco','sp','rgdal','V8','geojsonio')) # type 'n' when prompted to install from source
require(spatialEco)
require(sp)
require(rgdal)
require(geojsonio)
require(stringr)

## Get San Francisco's neighborhood Census tracts geojson file and plot.

# download.file('https://data.sfgov.org/api/geospatial/bwbp-wk3r?method=export&format=GeoJSON', 'census_tracts.geojson', 'auto')
census_tracts = geojson_read('data/GeoJSON/city_analysis_neighbor.geojson', what='sp')
plot(census_tracts)
census_tracts@data # view tract number, neighborhood, geoid for each polygon

# Get latest 311 case dataset (warning: very large file), drop a few fields, and match lon_lats to 
# the tract polygons they belong in. Then, preview.

# download.file('https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD', 'calls.csv', 'auto')
# calls = read.csv('calls.csv')
calls = read.csv('data/cases_sample.csv')
calls <- calls[,!(names(calls) %in% c("X.1","X.2","X.3","X"))]
coordinates_match_groups = str_match(calls$Point, "\\((\\d+.\\d+), (-?\\d+.\\d+)\\)$")
lon_lat = coordinates_match_groups[,3:2]
class(lon_lat) = "numeric" # convert strings to numbers
lon_lat[is.na(lon_lat)] = 0 # needed to run next line without errors
lon_lat = SpatialPointsDataFrame(lon_lat, calls, proj4string = census_tracts@proj4string)
calls_census_tracts = point.in.poly(lon_lat, census_tracts)
names(calls_census_tracts)[names(calls_census_tracts) == "geoid"] <- "Census.Tract"
names(calls_census_tracts)[names(calls_census_tracts) == "nhood"] <- "C.Neighborhood"
print(head(calls_census_tracts[c("Census.Block", "Census.Tract")]))

## Save new version of sample.
write.csv(calls_census_tracts, file = "data/cases_sample.csv")