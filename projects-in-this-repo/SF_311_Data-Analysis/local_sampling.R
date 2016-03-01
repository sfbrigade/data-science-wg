## !! Warning !!: Do NOT run this if you've already got access to data/cases_sample.Rdata or
## data/cases_sample.csv. It'll take forever to download the raw data.

##### Local Sampling Methodology #####
#  
#  This dataset is MASSIVE (~480 Mb). As such, if we're to fully explore this dataset, we'll 
#  need to load it locally and sample according to our application/reporting goals, including 
#  confidence and representativeness. Here's how we're doing so...
# 
#  1. Currently, nothing exotic: Just a basic random sampling of 5,000 records.
#       - In the future: Cluster sampling by year and/or neighborhood.
#  2.
#  3.
#
#################################

## Check for file and, if it doesn't exist, create the sample.
if(file.exists("data/cases_sample.csv")){
    cases_sample <- read.csv("data/cases_sample.csv")
} else {
    ## load from full local copy and do a basic random sample.
    ## !! Make sure you've already downloaded from (unless you wanna' use API): 
    ## !! https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD
    ## And save to subdirectory /data.
    full_cases <- read.csv("data/Case_Data_from_San_Francisco_311__SF311_.csv")
    cases_sample <- full_cases[sample(nrow(full_cases), 5000),]
    
    ## Save sample in CSV format.
    write.csv(cases_sample, file = "data/cases_sample.csv")
}


## Print test
print(paste("Rows in sample:", nrow(cases_sample)))
print(head(cases_sample))
print(tail(cases_sample))


