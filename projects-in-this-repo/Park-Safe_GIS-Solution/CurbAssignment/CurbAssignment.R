library(rgeos)
library(zoo)
library(dplyr)
library(sp)
library(geosphere)
library(rgdal)
library(doParallel)
cl <- makeCluster(4)
registerDoParallel(cl)
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
  samps$ord <- 1:nrow(samps)
  samps
}

makeLine <- function(grp){
  if(length(grp) == 1 ){
    return(data.frame())
  }
  grp <- grp[order(grp$ord),]
  x <- grp$coords.x1
  y <- grp$coords.x2
  breaks <- c(1, which(zoo(grp$ord) - lag(zoo(grp$ord)) > 1), nrow(grp))
  lineDF <- SpatialLinesDataFrame(SpatialLines(list(Lines(Line(cbind(x,y)), ID = grp$CNN[[1]]))), data = data.frame(row.names = grp$CNN[[1]], CNN = grp$CNN[[1]]))
  coord <- as.data.frame(coordinates(lineDF))
  ll <- vector("list", length(breaks)-1)
  for (i in 1: (length(breaks)-1)){
    if(breaks[i+1] == nrow(grp)){
      subcoord <- coord[(breaks[i]):nrow(grp),]
    } else {
      subcoord <- coord[(breaks[i]):(breaks[i+1]-1),]
    }
    # check if subset contains more than 2 coordinates
    if (nrow(subcoord) >= 2){
      Slo1<-Line(subcoord)
      Sli1<-Lines(list(Slo1),ID=paste0('section',i))
      ll[[i]] <- Sli1
    }
    
  }
  nulls <- which(unlist(lapply(ll,is.null)))
  if(length(nulls) > 0){
    ll <- ll[-nulls]
  }
  lin <- SpatialLines(ll)
  lin
}

getDF <- function(row){
  s <- findCNNS(row)
  linelist <- s %>% data.frame %>% group_by(CNN) %>% mutate(tot= n()) %>% filter(tot > 1) %>% do(l = makeLine(.)) %>% .$l 
  linelist
}

t <- foreach(i = 1:nrow(feats), .packages = c("sp", "rgeos", "geosphere", "rgdal", "dplyr", "zoo") ) %dopar% {
  list(getDF(feats[i,]))
}

t <- unlist(t)
t <- sapply(1:length(t), function(x) spChFIDs(t[[x]], paste0(as.character(x),"_", 1:length(t[[x]]))))
df <- do.call(rbind, t)
data <- data.frame(id = sapply(df@lines, function(x) x@ID))
rownames(data) <- sapply(df@lines, function(x) x@ID)
df2 <- SpatialLinesDataFrame(df, data = data)
proj4string(df2) <- proj4string(feats)
p4s <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")
transdf<- spTransform(df2, CRS= p4s)
writeOGR(transdf, 'curbs.kml','curbs', driver='KML')


