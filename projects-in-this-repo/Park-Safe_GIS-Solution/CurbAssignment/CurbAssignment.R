library(rgeos)
library(dplyr)
library(sp)
library(geosphere)
library(rgdal)
feats <- rgdal::readOGR('cityfeatures', 'cityfeatures')
streets <- rgdal::readOGR('stclines_streets', 'stclines_streets')

getCNN <- function(pt){
  dists <- rgeos::gDistance(pt, streets, byid = TRUE)
  streets[order(dists)[[1]],]$CNN
}

getMin <- function(row){
  smallest <- order(row)[[1]]
  streets[smallest,]$CNN
}

findCNNS <- function(row){
  samps <- spsample(row, 100, "regular")
  dists2 <- gDistance(samps, streets, byid = TRUE)
  CNNs <-apply(t(dists2), 1,getMin)
  samps$CNN <- CNNs
  samps
}

makeLine <- function(grp){
  x <- grp$coords.x1
  y <- grp$coords.x2
  SpatialLinesDataFrame(SpatialLines(list(Lines(Line(cbind(x,y)), ID = grp$CNN[[1]]))), data = data.frame(row.names = grp$CNN[[1]], CNN = grp$CNN[[1]]))
}

getDF <- function(row){
  s <- findCNNS(row)
  linelist <- s %>% data.frame %>% group_by(CNN) %>% do(l = makeLine(.)) %>% .$l 
  linelist
}

t <- list()
for(i in 1:10){
  t[[i]] <- getDF(feats[i,])
}
t <- unlist(t)
t <- sapply(1:length(t), function(x) spChFIDs(t[[x]], as.character(x)))
df <- do.call(rbind, t)
