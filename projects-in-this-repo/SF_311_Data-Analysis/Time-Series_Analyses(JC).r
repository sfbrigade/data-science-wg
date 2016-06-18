
## Get the data
library("AzureML")
ws <- workspace()
dat <- download.datasets(ws, "calls_census_tracts.csv")

## Preview the data
head(dat)

# Install Forecast. Doesn't seem to persist in Azure ML Studio.
install.packages("forecast")

# Load libraries
library(forecast)
library(ggplot2)
library(dplyr)
library(stats)

## Freq table of requests by Category.
req_counts <- data.frame(table(dat$Category))
req_counts <- req_counts[order(-req_counts$Freq),]
top5req <- req_counts[1:5,]
print(top5req)

# Format 'Opened' field to Posix, then Date.
dat$Opened <- as.POSIXct(strptime(dat$Opened, format = "%m/%d/%Y %I:%M:%S %p"), tz = "America/Los_Angeles")
dat$Opened <- as.Date(dat$Opened)

# Preview
head(dat$Opened)

# Subset to only those cases of the top 5 request categories.
cases_top5q <- dat[dat$Category %in% top5req$Var1,]

# Preview
print(head(cases_top5q, 3))

# View tail: Please note how those in the top 5 didn't start till 7/1/2008 (the data set is in descending
# chronological order). This is important to our time series considerations.
print(tail(cases_top5q, 3))

## Create a dataframe of all days, sequencing between first opened day to last. 
## Then change the first column's name to 'Var1' for later joining.
##
## This is because some days don't have any recorded requests for a given category, but proper
## time-series analyses require at least '0's for such days.
alldays <- as.data.frame(seq(tail(dat$Opened,1), head(dat$Opened,1), by = "day"))
names(alldays)[1] <- "Var1"

head(alldays)

## Get counts per top 5 category
cat_counts <- data.frame(table(dat$Category))
cat_counts <- cat_counts[order(-cat_counts$Freq),]
top5cat <- cat_counts[1:5,]

## Subset cases by top 5 category.
cases_top5c <- dat[dat$Category %in% top5cat$Var1,]

## Loop through creating freq DFs.
top5_freqs <- vector()
for(i in 1:5){
    cat_sub <- cases_top5c[cases_top5c$Category %in% top5cat$Var1[i],]
    cat_freq <- data.frame(table(cat_sub$Opened))
    cat_freq$Var1 <- as.Date(cat_freq$Var1)
    cat_freq <- right_join(cat_freq, alldays, by = "Var1")
    cat_freq$Freq[is.na(cat_freq$Freq)] <- 0
    names(cat_freq)[1] <- "Date"
    
    top_rank <- paste0("cat",i,"_freq")
    assign(top_rank, cat_freq)
    
    # Catching DF names for later use.
    top5_freqs <- append(top5_freqs, top_rank)
}

## Preview/test
paste("Rows in No. 1 category freq table:", nrow(cat1_freq))
paste("Rows in No. 5 category freq table:", nrow(cat5_freq))
head(cat1_freq[cat1_freq$Date >= "2008-07-01",])
head(cat5_freq[cat5_freq$Date >= "2008-07-01",])

## Loop through creating daily, weekly, and monthly TS objects per top 5 category.
for(i in 1:5){
    # Subset to span of 7/1/08 -> 3/1/16, because these categories aren't really recorded until 7/1/08.
    # We can probably just comment this line out later...
    current_cat <- get(top5_freqs[i])
    ts_sub <- current_cat[current_cat$Date >= "2008-07-01" & current_cat$Date < "2016-03-01",]
    
    # Create daily time series
    cat_ts_day <- ts(ts_sub$Freq, frequency = 365)
    
    # Name daily ts by index in loop
    ts_rank_day <- paste0("cat",i,"_ts_day")
    assign(ts_rank_day, cat_ts_day)
    
    # Weekly time series
    cat_freq_w <- summarise(group_by(ts_sub, format(ts_sub$Date, "%Y%W")), Freq = sum(Freq))
    names(cat_freq_w)[1] <- "Y.Week"
    cat_ts_week <- ts(cat_freq_w$Freq, frequency = 53)
    
    # Name weekly ts by index in loop
    ts_rank_week <- paste0("cat",i,"_ts_week")
    assign(ts_rank_week, cat_ts_week)
    
    # Monthly time series
    cat_freq_m <- summarise(group_by(ts_sub, format(ts_sub$Date, "%Y%m")), Freq = sum(Freq))
    names(cat_freq_m)[1] <- "Y.Month"
    cat_ts_month <- ts(cat_freq_m$Freq, frequency = 12)
    
    # Name monthly ts by index in loop
    ts_rank_month <- paste0("cat",i,"_ts_month")
    assign(ts_rank_month, cat_ts_month)
    
}

## Test and preview
length(cat1_ts_day)
head(cat1_ts_day)
tail(cat1_ts_day)

length(cat3_ts_week)
head(cat3_ts_week)
tail(cat3_ts_week)

length(cat5_ts_month)
head(cat5_ts_month)
tail(cat5_ts_month)

# Quick seasonal decomp via STL method. Might not be optimal, but probably good for exploration.
# More on stl and Loess: http://align-alytics.com/seasonal-decomposition-of-time-series-by-loessan-experiment/
# More on forecasting from decomposition: https://www.otexts.org/fpp/6/6

# This is by year, btw (with 365 days within each year).
plot(stl(cat1_ts_day, s.window = "periodic"), col = "forestgreen")

# Also by year (with 53 weeks within each year).
plot(stl(cat1_ts_week, s.window = "periodic"), col = "red")

# Also by year (with 12 months within each year).
plot(stl(cat1_ts_month, s.window = "periodic"), col = "dodgerblue")

## Install and invoke Anamoly Detection package via Devtools
install.packages("devtools")

library(devtools)
devtools::install_github("twitter/AnomalyDetection")

library(AnomalyDetection)

## Grab a test category full of data.
top1_cat <- get(top5_freqs[1])

## Subset to cases from two years prior to the user's query date (presumably, today).
cat1_df <- top1_cat[top1_cat$Date >= (Sys.Date() - 730),]

## Preview
head(cat1_df)
dim(cat1_df)

## Anomaly detection package only accepts POSIXct, so let's convert to that.
cat1_df$Date <- as.POSIXct(strptime(cat1_df$Date, "%Y-%m-%d"))
class(cat2_df$Date)

head(cat1_df)
tail(cat1_df)

## Detect anomalies but only in the positive direction (not sure how useful the negative direction would be).
res <- AnomalyDetectionTs(cat1_df, max_anoms=0.05, direction='pos', plot=TRUE)
res$plot
print(res$anom)

## Is/was today or yesterday anomolous? I check for today or yesterday in case there are -or aren't- yet enough
## cases to do a proper check of today.
today_anom <- grepl(Sys.Date(), tail(res$anom$timestamp, 2))
print(today_anom)


