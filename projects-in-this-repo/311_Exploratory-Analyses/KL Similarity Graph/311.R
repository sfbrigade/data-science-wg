library(dplyr)
library(readr)
library(reshape2)
# This requires that you download the case data from the SF data website
# https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6
df <- read_csv('Case_Data_from_San_Francisco_311__SF311_.csv')

# Pivot data by neighborhood; aggregate by category
pivdf <- df %>% melt(id.var = "Neighborhood", measure.vars = c("Category") ) %>% group_by(Neighborhood, value) %>% summarize(tot = n()) %>% dcast(Neighborhood ~ value, value.var = "tot")

# Set NA to 0
pivdf[is.na(pivdf)] <- 0

# Convert to matrix and normalize
norm <- pivdf %>% select(-Neighborhood) %>% as.matrix()
sums <- norm %>% apply(1, sum)
norm <- norm / sums

# Define KL divergence calculator 
KL <- function(x,y) {
  sum(x*(log(x)  - log(y)) + y*(log(y) - log(x)), na.rm = TRUE)
}

# Get rows of matrix
n <- nrow(norm)

# Preallocate similarity matrix
divs <- matrix(, nrow = n , ncol = n)
# Calculate similarities
for(i in 1:n){
  for(j in 1:n){
    if(i == j){
      divs[i,j] <- 0
    } else {
      val <- KL(norm[i,], norm[j,])
    divs[i,j] <- val 
    }
  }
}
# Convert to data frame
divs <- as.data.frame(divs)
# Add ID
divs$id <- 1:n
# Melt matrix
m <- melt(divs, id.vars = "id")
# Fix column names
m$variable <- stringr::str_replace(m$variable, "V", "")
# Edit for export to Gephi
colnames(m) <- c("Source", "Target", "weight")
m$Source <- sapply(m$Source, function(x) pivdf$Neighborhood[x]) 
m$Target <- sapply(m$Target, function(x) pivdf$Neighborhood[as.numeric(x)]) 
# Convert distances to similarities
m$weight <- exp(-m$weight)
# Sparsify to top 6 graph
m <- m %>% group_by(Source) %>% top_n(6, weight)
# Write graph
write_csv(m, 'edges.csv')
