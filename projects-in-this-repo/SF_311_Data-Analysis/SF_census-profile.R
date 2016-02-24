library(readr)

######## This script simply joins a few Census ACS tables to form a 'mini' Census profile for San Francisco. ########

## Get the data.
pop_est <- read_csv("data/ACS_14_5YR-POP/ACS_14_5YR_B01003_with_ann.csv")[-c(1,3)] # Total population.
inc_est <- read_csv("data/ACS_14_5YR-INCOME/ACS_14_5YR_B19301_with_ann.csv")[-c(1,3)] # Per cap income (past 12m).
agesex_est <- read_csv("data/ACS_14_5YR-AGESEX/ACS_14_5YR_B01002_with_ann.csv")[-c(1,3)] # Median age by sex.

## Save the secondary headers somewhere, then remove them.
pop_head2 <- pop_est[1,]
pop_est <- pop_est[-1,]
inc_head2 <- inc_est[1,]
inc_est <- inc_est[-1,]
agesex_head2 <- agesex_est[1,]
agesex_est <- agesex_est[-1,]

## Rename some fields.
colnames(pop_est)[2] <- "Population"
colnames(inc_est)[2] <- "Income"
colnames(agesex_est)[2] <- "Med.Age"
colnames(agesex_est)[4] <- "Med.Age.M"
colnames(agesex_est)[6] <- "Med.Age.F"

## Drop margins of error (for now).
pop_est <- pop_est[-3]
inc_est <- inc_est[-3]
agesex_est <- agesex_est[-c(3,5,7)]

## Column bind them all (all census blocks match by row, so we're good to go with just
## keeping the first DF's blocks).
cblock_profile <- cbind(pop_est, inc_est[-1], agesex_est[-1])
colnames(cblock_profile)[1] <- "C.Block"

## Some final cleaning: Coerce all fields to numeric and coerce matrix back to DF.
cblock_profile[,-1] <- sapply(cblock_profile[,-1], function(x) as.numeric(as.character(x)))
cblock_profile <- as.data.frame(cblock_profile)

## Preview
print(head(cblock_profile))

## Save SF mini census profile (based on 5 yr ACS estimates).
write.csv(cblock_profile, "data/sf_census-profile.csv")


######### Intersect w/311 case neighborhoods #########

## Get data
cases_sample <- read_csv("data/cases_sample.csv")

## Compile blocks per neighborhood and create per-neighborhood profile.
nb_profile <- data.frame()
nb_uniq <- unique(levels(cases_sample$Neighborhood))
for(i in 1:length(nb_uniq)){
    ## Get all Census blocks for the Neighborhood at this index. 
    ## Then, subset the Census block profile DF to only those Cblocks of this neighborhood.
    nb_cb <- cases_sample$Census.Block[cases_sample$Neighborhood %in% nb_uniq[i]]
    nb_sub <- cblock_profile[unique(match(nb_cb, cblock_profile$C.Block)),]
    
    ## Compute total pop per neighborhood of demand.
    Total.Pop <- sum(nb_sub$Population)
    
    ## Use whatever summary stat you want here (e.g. median). Btw, lapply cuts a step (vs. sapply).
    nb_sub <- lapply(nb_sub[-c(1,2)], function(x) median(x))
    nb_sub <- as.data.frame(nb_sub)
    
    ## Column bind to total pop per neighborhood and then row bind to the larger DF.
    nb_sub <- cbind(nb_uniq[i], Total.Pop, nb_sub)
    colnames(nb_sub)[1] <- "Neighborhood"
    colnames(nb_sub)[3] <- "Med.Income"
    nb_profile <- rbind(nb_profile, nb_sub)
}

## Preview
print(head(nb_profile))

## Save SF mini census profile (based on 5 yr ACS estimates).
write_csv(nb_profile, "data/sf_neighborhood-census-profile.csv")

