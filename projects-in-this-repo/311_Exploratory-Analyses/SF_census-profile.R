##### This script simply joins a few Census ACS tables to form a 'mini' Census profile for San Francisco. #####

## Get the data.
pop_est <- read.csv("data/ACS_14_5YR-POP/ACS_14_5YR_B01003_with_ann.csv")[-c(1,3)] # Total population.
inc_est <- read.csv("data/ACS_14_5YR-INCOME/ACS_14_5YR_B19301_with_ann.csv")[-c(1,3)] # Per cap income (past 12m).
agesex_est <- read.csv("data/ACS_14_5YR-AGESEX/ACS_14_5YR_B01002_with_ann.csv")[-c(1,3)] # Median age by sex.

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

## Convert all GEO.id2 to character and then numeric, for future matching.
pop_est$GEO.id2 <- as.numeric(as.character(pop_est$GEO.id2))
# inc_est$GEO.id2 <- as.numeric(as.character(inc_est$GEO.id2))
# agesex_est$GEO.id2 <- as.numeric(as.character(agesex_est$GEO.id2))

## Column bind them all (all census blocks match by row, so we're good to go with just
## keeping the first DF's blocks).
cblock_profile <- cbind(pop_est, inc_est[-1], agesex_est[-1])
colnames(cblock_profile)[1] <- "C.Block"

## Preview
print(head(cblock_profile))

## Save SF mini census profile (based on 5 yr ACS estimates).
write.csv(cblock_profile, "data/sf_census-profile.csv")