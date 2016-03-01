library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(dplyr)

## Load data and do some cleaning.
cases_sample <- na.omit(read.csv("data/cases_sample.csv"))
levels(cases_sample$Neighborhood)[levels(cases_sample$Neighborhood)==""] <- "NOT DEFINED"

## Convert Opened and Closed days + times to usable format.
cases_sample$Opened <- as.POSIXct(strptime(cases_sample$Opened, format = "%m/%d/%Y %I:%M:%S %p"), tz = "America/Los_Angeles")
cases_sample$Closed <- as.POSIXct(strptime(cases_sample$Closed, format = "%m/%d/%Y %I:%M:%S %p"), tz = "America/Los_Angeles")

## Create 'Resolve time' from difference between Open and Close times.
cases_sample$Resolve.Time <- round(difftime(cases_sample$Closed, cases_sample$Opened, units = "hours"), 2)
cases_sample$Resolve.Time <- as.numeric(cases_sample$Resolve.Time)
is.na(cases_sample$Resolve.Time) <- 0

## Preview data
print(head(cases_sample))


##### Some quickie plots: 311 request sources #####

## Begin w/Freq. table
sources311 <- data.frame(table(cases_sample$Source))
sources311 <- sources311[order(-sources311$Freq),]
sources311$Var1 <- reorder(sources311$Var1, sources311$Freq)

## Flipped bar chart.
sourcebar <- ggplot(sources311, aes(x = Var1, y = Freq, fill = Var1))
sourcebar <- sourcebar + geom_bar(width = 1, stat = "identity") + xlab("")
sourcebar <- sourcebar + theme(legend.position = "none", axis.text.x = element_blank(), axis.ticks.y = element_blank())
sourcebar <- sourcebar + coord_flip() + geom_text(label=format(sources311$Freq, digits=2), size = 4)

## Pie chart. Requires new DF, just to trick GGplot to put labels in the right places.
sources311b <- sources311
sources311b$pct <- sources311$Freq/sum(sources311$Freq)
sources311b$pos <- cumsum(sources311b$Freq) - 0.75*sources311b$Freq
sourcepie <- ggplot(sources311b, aes(x = "", y = Freq, fill = Var1))
sourcepie <- sourcepie + geom_bar(width = 1, stat = "identity")
sourcepie <- sourcepie + ylab("Freq / All") + xlab("") + coord_polar("y") 
sourcepie <- sourcepie + theme(legend.position="none", axis.ticks.x = element_blank(), axis.ticks.y = element_blank())
sourcepie <- sourcepie + geom_text(aes(label = percent(pct), y = pos, size = 4))

print(grid.arrange(sourcebar, sourcepie, ncol = 2, top = paste0("311 Request Frequency by Source ", "(Total = ", nrow(cases_sample),")")))

###### Neighborhood demand breakdown ######

## Begin w/freq table of neighborhoods.
neigh311 <- data.frame(table(cases_sample$Neighborhood))
neigh311 <- neigh311[order(-neigh311$Freq),]
neigh311$Var1 <- reorder(neigh311$Var1, neigh311$Freq)

## Flipped bar chart.
neighbar <- ggplot(neigh311[1:10,], aes(x = Var1, y = Freq, fill = Freq))
neighbar <- neighbar + geom_bar(width = 1, stat = "identity") + xlab("")
neighbar <- neighbar + theme(legend.position = "none", axis.text.x = element_blank(), axis.ticks.y = element_blank())
neighbar <- neighbar + coord_flip() + geom_text(aes(label=Freq, digits=2), size = 4)
neighbar <- neighbar + ggtitle("311 Requests Freq by Neighborhood: Top 10")

print(neighbar)

## Neighborhood demand by type.
## Use only the top 5.
neightype <- cases_sample[cases_sample$Neighborhood %in% neigh311$Var1[1:5],]
reqst <- data.frame(table(neightype$Request.Type))
reqst <- reqst[order(-reqst$Freq),]
neightype <- neightype[neightype$Request.Type %in% reqst$Var1[1:10],]

## Panel bar chart.
typebar <- ggplot(neightype, aes(Request.Type, fill = Request.Type)) + facet_wrap(~Neighborhood)
typebar <- typebar + geom_bar(stat = "bin", position = "stack") + xlab("") + ylab("")
typebar <- typebar + ggtitle("Request Types Per Top 5 Neighborhood")
typebar <- typebar + theme(axis.text.x = element_blank())

print(typebar)

## Total demand by type.
## Use only the top 5.
req311 <- data.frame(table(cases_sample$Request.Type))
req311 <- req311[order(-req311$Freq),]
req311$Var1 <- reorder(req311$Var1, req311$Freq)

## Flipped bar chart.
req311bar <- ggplot(req311[1:10,], aes(x = Var1, y = Freq, fill = Freq))
req311bar <- req311bar + geom_bar(stat = "identity") + ggtitle("Request Types by Overall Demand")
req311bar <- req311bar + coord_flip() + theme(legend.position = "none")

print(req311bar)

######### Response Times Exploration: Very Rough ##########

## First, let's summarize sheer neighborhood by mean resolution time.
meanres_neigh <- summarise(group_by(cases_sample, Neighborhood), round(mean(Resolve.Time),2))
colnames(meanres_neigh)[2] <- c("Mean.Resolve")

## Let's also summarize sheer request type by mean resolution time.
meanres_req <- summarise(group_by(cases_sample, Request.Type), round(mean(Resolve.Time),2))
colnames(meanres_req)[2] <- c("Mean.Resolve")

## Finally, let's summarize by means per request type in each neighborhoood.
meanres_nereq <- summarise(group_by(cases_sample, Neighborhood, Request.Type), round(mean(Resolve.Time),2))
colnames(meanres_nereq)[3] <- c("Mean.Resolve")

#### Now, let's compare mean response times, per neighborhood, across all request types...

## Neighborhoods w/shortest resolution times.
meanres_neigh <- meanres_neigh[order(meanres_neigh$Mean.Resolve),]
print(meanres_neigh[1:10,])

## Neighborhoods w/longest resolution times.
meanres_neigh <- meanres_neigh[order(-meanres_neigh$Mean.Resolve),]
print(meanres_neigh[1:10,])

#### Now, let's compare mean response times, per sheer request type...

## Req types w/longest mean resolution times.
meanres_req <- meanres_req[order(meanres_req$Mean.Resolve),]
print(meanres_req[1:10,])

## Req types w/longest mean resolution times.
meanres_req <- meanres_req[order(-meanres_req$Mean.Resolve),]
print(meanres_req[1:10,])

#### Let's compare mean response times, per neighborhood + request type...

## Beginning w/street cleaning.
meanres_street <- meanres_nereq[meanres_nereq$Request.Type == "Street_Cleaning",]
meanres_street <- meanres_street[order(-meanres_street$Mean.Resolve),]
print(meanres_street[1:10,])

## Let's do the same for sidewalk cleaning.
meanres_side <- meanres_nereq[meanres_nereq$Request.Type == "Sidewalk_Cleaning",]
meanres_side <- meanres_side[order(-meanres_side$Mean.Resolve),]
print(meanres_side[1:10,])

## Some pretty panel plotting by req. type per top 5 most requesting neighborhoods.
top5neigh <- neigh311$Var1[1:5]
top5reqs <- req311$Var1[1:5]
meanres_req_p <- meanres_nereq[(meanres_nereq$Neighborhood %in% top5neigh)
                               & (meanres_nereq$Request.Type %in% top5reqs),]
# meanres_req_p$Mean.Resolve <- as.numeric(meanres_req_p$Mean.Resolve)
# is.na(meanres_req_p$Mean.Resolve) <- 0
meanres_plot <- ggplot(meanres_req_p, aes(x=Request.Type, y=as.numeric(Mean.Resolve)))
meanres_plot <- meanres_plot + geom_bar(stat = "identity") + facet_wrap(~Request.Type)
print(meanres_plot)
