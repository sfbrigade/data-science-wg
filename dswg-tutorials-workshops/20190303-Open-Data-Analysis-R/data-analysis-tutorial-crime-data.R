### 
#     Open Data Analysis in R Workshop
#     Presented at Code for SF OPEN DATA DAY 2019
#     Date: 03/03/19
#     Author: Rocio Ng (Data Science Working Group, @rocio on sfbrigade slack)
#

# Pre-requsite Steps
# 1. Download the Latest version of R (https://cran.r-project.org/) and R Studio (https://www.rstudio.com/)
# 2. Create a new folder for your project
# 3. Open R-Studio
# 3. Create a new project by clicking on the drop down menu in the upper right 
#    and selecting 'New Project'
# 4. Select `Existing Directory` and select your project folder

#### Load needed Packages
# To install a package type in install.packages('<Name of Package>'). Make sure to use Quotes
library(dplyr) # For easy data manipulations
library(tidyr) # For data cleaning/manipulation - Not used here but useful to learn
library(ggplot2) # For Data Manipulation
library(lubridate) # For working with Date time objects

##### Read in the Crime Dataset 
# URL Source: https://data.sfgov.org/Public-Safety/Police-Department-Incident-Reports-2018-to-Present/wg3w-h783
# Make sure to download CSV for Excel
# Dowload File into your project Folder
crime_data_raw <- read.csv("Police_Department_Incident_Reports__2018_to_Present.csv", 
                           na.strings = "")  # Some missing data are NA many are empty string

# Useful Functions for understanding the Dataset
head(crime_data_raw, n=20)
tail(crime_data_raw)
dim(crime_data_raw)
str(crime_data_raw) # type ?str to get more information on this function
summary(crime_data_raw)

# Get Counts of Missing Data
colSums(is.na(crime_data_raw))

# Explore Some of the Columns
levels(crime_data_raw$Incident.Category)
levels(crime_data_raw$Supervisor.District) # only works for Factors, will throw NULL
levels(as.factor(crime_data_raw$Supervisor.District))


##### Basic Data Manipulation with Base R Functions
# Subseting
sub1 <- crime_data_raw[ ,c(2, 6:10)] # by column
head(sub1)
sub2 <- crime_data_raw[c(2:10), ] # by row
dim(sub2)
sub3 <-crime_data_raw[c(2:4), c(15,1,3)] # by both
sub3
sub4 <- crime_data_raw[, c('Incident.Date','Incident.Category')] # using column names
head(sub4)

# Removing Variables to clean up workspace
rm(sub1, sub2, sub3, sub4)

# Filtering
filter1 <- crime_data_raw[which(crime_data_raw$Incident.Year == 2018), ]

# Good Sanity Check, Always check to make sure your subsets/filters are applied correctly
levels(as.factor(crime_data_raw$Incident.Year))
levels(as.factor(filter1$Incident.Year)) 


#### EXERCISE: Write code that will result in a dataset that
#               filters for the Analysis.Neighborhood 'South of Market'    


# Write code here!!!


###### Using Dplyr!
# The rest of the script leverages the dplyr package, an awesome tool for data manipulation
# Code is more readable and you can `pipe` functions together
# For More Info Check out: https://dplyr.tidyverse.org/

# Subseting/Filtering with Dplyr functions.  
sub1 <- crime_data_raw %>% select(Incident.Date, Incident.Category:Resolution)
head(sub1)

# Filtering for Drug Offenses
drug_offense <- crime_data_raw %>% 
  select(Incident.Date, Incident.Year, Incident.Category:Resolution) %>%
  filter(Incident.Category == 'Drug Offense')
head(drug_offense)

# What are the type of resolutions
levels(drug_offense$Resolution)

# What if we are only interested in seeing Adult related Resolutions in 2018?
adult_drug_offense <- drug_offense %>% 
  filter(Resolution %in% c('Cite or Arrest Adult', 'Exceptional Adult'),
         Incident.Year == 2018) %>% droplevels()
str(adult_drug_offense) # Use droplevels if other factor levels are still showing up

#### EXERCISE: Write Code using Dplyr functions that returns a dataset that
#            Includes Date, Year, Day of the Week,  Categories filters
#            for Categories 'Vandalism' and 'Lost Property'
#            that occurred during weekends



# WRITE SOME CODE !! :)




##### AGGREGATIONS

### Counts
# Total Count of all incidents
total_crimes <- crime_data_raw %>% summarise(total_crimes=n())
total_crimes

# Total Distinct neighborhood
total_neighborhoods <- crime_data_raw %>% 
  filter(!is.na(Analysis.Neighborhood)) %>% # remove Nulls!!
  summarise(total_neighborhoods=n_distinct(Analysis.Neighborhood))
total_neighborhoods

### Group Bys
# Which neighborhoods/districts have the most reported crimes?
# By Neighborhood
by_neighborhood <- crime_data_raw %>% group_by(Analysis.Neighborhood) %>%
  summarise(total_crimes=n()) %>% arrange(-total_crimes)
by_neighborhood

# Look at Districts
by_district <- crime_data_raw %>% group_by(Police.District) %>%
  summarise(total_crimes=n()) %>% arrange(-total_crimes)
by_district

# Counts by District and Neighborhoods
by_area <- crime_data_raw %>% group_by(Police.District, Analysis.Neighborhood) %>%
  summarise(total_crimes=n()) %>% arrange(-total_crimes)
by_area

## USE the Data exploration tool in the Rstudio UI (click on the dataset)
# Explore the by_area dataset and notice there are some discrepancies
# between mappings of neighborhoods and districts.  It is important to 
# thoroaughly explore your datasets especially open data sources
# Question:  How would you handle this discrepancy?  Does it affect all 
#            potential questions you would explore?

# Which Districts tend to be missing Neighborhoods?
# Missing neighborhoods are fairly distributed among districts
area_missing <- by_area %>% filter(is.na(Analysis.Neighborhood))


#### EXERCISE : Write Code using Dplyr that returns a dataset that shows the
#             counts of Incident Categories by Neighborhood
#             Sort by Neighborhood and total incidents DESC
#             Remove nulls for neighborhoods



#### EXERCISE:  Calculate the Average Number of Crimes per day.  
# Hint:  You might have to apply more than one aggregation step ;)




#### SAMPLE DATA EXPLORATION: 
# Investigate which types of crimes are most common in 2018

# Categories of crime
levels(crime_data_raw$Incident.Category)
# There are some categories with typos 

# This help show that these labels mean the same things
mvt <- crime_data_raw %>% 
  filter(Incident.Category %in% c('Motor Vehicle Theft?', 'Motor Vehicle Theft'))
# This shows that these labels mean DIFFERENT things. no recoding here
s <- crime_data_raw %>% 
  filter(Incident.Category %in% c('Suspicious', 'Suspicious Occ'))

# We need to recode some items in the Incident.Category field
## Using the MUTATE function which allows you to create new columns

# How to recode
crime_data_raw <- crime_data_raw %>% 
  mutate(Incident.Category.Clean = 
           recode(Incident.Category, 'Weapons Offence' = 'Weapons Offense',
                  'Human Trafficking (A), Commercial Sex Acts' = 
                    'Human Trafficking, Commercial Sex Acts',
                  'Motor Vehicle Theft?'= 'Motor Vehicle Theft'))
# Check data levels
levels(crime_data_raw$Incident.Category.Clean)








# Counts by Incident Category
by_category <- crime_data_raw %>% group_by(Incident.Category.Clean) %>%
  filter(Incident.Year == 2018) %>%
  summarise(total = n()) %>% arrange(-total)
head(by_category) 
# Larceny Theft is the most common..but this is vague. Let's dig more!

larceny <- crime_data_raw %>% 
  filter(Incident.Category == 'Larceny Theft',
         Incident.Year == 2018) %>% 
  droplevels()
levels(larceny$Incident.Subcategory)

# Counts by SubCategory
larceny2 <- larceny %>% group_by(Incident.Subcategory) %>%
  summarise(total = n()) %>% arrange(-total)
larceny2

by_day <- larceny %>%
  group_by(Incident.Date) %>% summarise(total=n()) 

# Plot by Day using ggplot visualizaiton
ggplot(aes(x=Incident.Date, y=total), data = by_day) + geom_line(group=1)

# This is not very helpful so lets plot by month
by_month <- larceny %>% mutate(Incident.Date = as_date(Incident.Date),
                               Incident.Month = month(Incident.Date)) %>%
  group_by(Incident.Month) %>%
  summarise(total = n())

# Plot
ggplot(aes(x=as.factor(Incident.Month), y = total), data = by_month) +
  geom_line(aes(group=1))+
  labs(x = 'Month', y = 'Total Incidents')

# Some interesing peaks/dips -- Lets see what may be causing this
# By Month and SubCategory
by_month_category <- larceny %>% mutate(Incident.Date = as_date(Incident.Date),
                                      Incident.Month = month(Incident.Date)) %>%
  group_by(Incident.Month, Incident.Subcategory) %>%
  summarise(total = n())
# Plot
ggplot(aes(x=as.factor(Incident.Month), y = total), data = by_month_category) +
  geom_line(aes(group=Incident.Subcategory, color = Incident.Subcategory))+
  labs(x = 'Month', y = 'Total Incidents')

# Cool Larceny from vehicles are driving the yearly pattern we see
# There is a spike during the summer, maybe due to influx of tourists?
# Not cool for the victims tho :(



#### Try some investigation on your own!! -- Feel free to explore subCategories
# I would suggest Focusing on 2018 year

####### --------------- More Questions to Explore ----------------------------- ######
# Which Month has the highest Average number of Crimes? By Crime Type?
# What hour/days are crimes/crime types more likely to occur? 
# Are certain crimes more likely to occur in specific neighbohoods? 
# What other analysis/data visualization can help Police be more effective?
# Come up with your own!!!

