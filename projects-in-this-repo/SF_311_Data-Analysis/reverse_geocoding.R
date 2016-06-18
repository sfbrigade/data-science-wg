## This script, by Jude Calvillo, taps two APIs to get the FIPS/Census Block code, Zip code, and Map URL of
## each 311 case, according to its coordinates.

## PLEASE NOTE: Our final analyses ended up using tracts (not blocks), but we nonetheless 
## feel this script could be useful to some.

## Load libraries.
library(httr)
library(jsonlite)

## Get cases sample.
cases_sample <- read.csv("data/cases_sample.csv", na.strings = "")

## !! Temporary solution to those few instances where no address/location was given
## !! Logically, we cannot select some random neighborhood's coordinates, as this could
## !! skew our data, nor are there citywide fields in census data. Therefore, we'll probably
## !! have to later fill in the census-derived fields for these records with some mean/median statistics.
cases_sample <- cases_sample[!(is.na(cases_sample$Point)),]

## It seems useful, for now and in the future, to split the 'Point' coordinates into two fields.
latlong <- strsplit(as.character(cases_sample$Point), ", ")
latlong <- lapply(latlong, function(x){gsub("\\(|\\)", "", x)})
latlong <- unlist(latlong)
cases_sample$Lat <- latlong[c(T,F)] # I cheated :)
cases_sample$Long <- latlong[c(F,T)]


############ Call FCC Census block API. #############

## Create empty Census.Block vector.
Census.Block <- vector()

## Looping through FCC API call.
for(i in 1:nrow(cases_sample)){
    fcc_url <- paste0("http://data.fcc.gov/api/block/find?format=json&latitude=", cases_sample$Lat[i],
                      "&longitude=", cases_sample$Long[i])
    fcc_api_req <- GET(fcc_url)
    fcc_json <- content(fcc_api_req, as = "text")
    fcc_info <- fromJSON(fcc_json)
    
    Census.Block <- append(Census.Block, fcc_info$Block$FIPS)
}

## Add to original sample.
cases_sample$Census.Block <- Census.Block

## Test preview of Census blocks.
print(head(cases_sample$Census.Block))
print(length(cases_sample$Census.Block))


############# Call MapQuest API for zips. #############

## App creds.
mquest_key <- read.csv("mquest_creds.csv")$app_key

## Create empty zip code and mapUrl vectors.
Zip <- vector()
Map.Url <- vector()
    
## Loop through Mapquest API call.
for(i in 1:nrow(cases_sample)){
    mquest_url <- paste0("http://open.mapquestapi.com/geocoding/v1/reverse?key=", mquest_key,
                         "&outFormat=json&callback=renderReverse&location=", paste0(cases_sample$Lat[i], ",", cases_sample$Long[i]))
    mquest_api_req <- GET(mquest_url)
    mquest_json <- content(mquest_api_req, as = "text")
    mquest_json <- gsub("renderReverse\\(|\\)", "", mquest_json)
    mquest_info <- fromJSON(mquest_json)
    
    loc_info <- as.data.frame(mquest_info$results$locations)
    
    Zip <- append(Zip, loc_info$postalCode)
    Map.Url <- append(Map.Url, loc_info$mapUrl)
}

## Add to original sample.
cases_sample$Zip <- Zip
cases_sample$Map.Url <- Map.Url

## Test preview.
print(head(cases_sample$Zip))
print(length(cases_sample$Zip))
print(head(cases_sample$Map.Url))
print(length(cases_sample$Map.Url))

## Save newest version of sample.
write.csv(cases_sample, file = "data/cases_sample.csv")

