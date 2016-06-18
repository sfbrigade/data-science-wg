library(rgeos)
library(dplyr)
library(sp)
library(geosphere)
library(rgdal)
library(doParallel)
# This is to run the process in parallel, using the doParallel package. The processing is processor-intensive, so this is a good idea.
cl <- makeCluster(4)
registerDoParallel(cl)

# Download the shapefiles if they do not exist.
if(!dir.exists(paste0(getwd(), "/stclines_streets"))){
  featurl <- "https://data.sfgov.org/download/wbm8-ratb/ZIP"
  tf <- tempfile()
  download.file(featurl, tf)
  unzip(tf, exdir =  "./stclines_streets")
}

if(!dir.exists(paste0(getwd(), "/cityfeatures"))){
  stlurl <- "https://data.sfgov.org/download/nvxg-zay4/ZIP"
  tf <- tempfile()
  download.file(stlurl, tf)
  unzip(tf, exdir = "./cityfeatures")
}

# Load in the shapefiles.
feats <- readOGR('cityfeatures', 'cityfeatures')
streets <- readOGR('stclines_streets', 'stclines_streets')

# A function which gets the closest CNN to a given point.
getCNN <- function(pt){
  dists <- rgeos::gDistance(pt, streets, byid = TRUE)
  streets[order(dists)[[1]],]$CNN
}

# A function which gets the CNN corresponding to the closest CNN.
getMin <- function(row){
  smallest <- order(row)[[1]]
  streets[smallest,]$CNN
}

# A function which samples 100 points along a curb segment, then assigns each point to a CNN. They can then be grouped by assigned CNN and formed into subsegments. 
findCNNS <- function(row){
  samps <- spsample(row, 100, "regular")
  dists2 <- gDistance(samps, streets, byid = TRUE)
  CNNs <-apply(t(dists2), 1,getMin)
  samps$CNN <- CNNs
  samps
}

# A function that makes a SpatialLinesDataFrame from a collection of points that represents a single-CNN subsegment we have generated previously. 
makeLine <- function(grp){
  x <- grp$coords.x1
  y <- grp$coords.x2
  SpatialLinesDataFrame(SpatialLines(list(Lines(Line(cbind(x,y)), ID = grp$CNN[[1]]))), data = data.frame(row.names = grp$CNN[[1]], CNN = grp$CNN[[1]]))
}

# Produces a list of subsegments for each row, which corresponds to a curb segment. 
getDF <- function(row){
  s <- findCNNS(row)
  linelist <- s %>% data.frame %>% group_by(CNN) %>% do(l = makeLine(.)) %>% .$l 
  linelist
}

# Runs the CNN assignment in parallel.
t <- foreach(i = 1:100, .packages = c("sp", "rgeos", "geosphere", "rgdal", "dplyr") ) %dopar% {
  list(getDF(feats[i,]))
}

# Collects all of the resulting data frames from the previous computation. At the end, df is a data frame which can be written to a shapefile, consisting of curb segments that have an attribute that labels them with an assigned CNN.
t <- unlist(t)
t <- sapply(1:length(t), function(x) spChFIDs(t[[x]], as.character(x)))
df <- do.call(rbind, t)
