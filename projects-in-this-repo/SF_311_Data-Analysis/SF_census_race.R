require(magrittr)
require(tidyr)
require(dplyr)


race_est <- dplyr::tbl_df(read.csv('data/ACS_14_5YR-ETHNICITY/ACS_14_5YR_C02003.csv', stringsAsFactors = FALSE))[-c(1,3,22,24)] # Individual Ethnic Identities

## rename column names
colnames(race_est) <- race_est[1,]
marg <- grep("Margin of Error;", colnames(race_est))
race_est <- race_est[-marg]
race_est <- race_est[-1,]

## Renaming columns as (Num of Races, Race) pairs
colnames(race_est) <- colnames(race_est) %>% 
        gsub('Estimate; ','', .) %>%
        gsub('Black or African American','Black', .) %>%
        gsub('American Indian and Alaska Native','Native', . ) %>%
        gsub('Native Hawaiian and Other Pacific Islander','Pacific.Islander', . ) %>%
        gsub('Asian alone', 'Asian',  . ) %>%
        gsub('Some other race','Other', . ) %>%
        gsub('All other two race combinations', 'Other_Combination', . ) %>%
        
        gsub('Population of one race:', '1:',  . ) %>%
        gsub('Population of two or more races: - Population of two races:', '2:',  . ) %>%
        gsub('Population of two or more races: - Population of three races', '3:',  . ) %>%
        gsub('Population of two or more races: - Population of four or more races', '4+:',  . ) %>%
        gsub('Population of two or more races:', '2+:',  . ) %>%
        gsub('Total:', 'Total', . ) %>%
        gsub('Id2','C.Block', . ) %>%
        
        gsub(' - ', '', . )


# race_tots <- tbl_df(race_est[c('C.Block','1:','2:','3:','4+:')])

race_est <- race_est[!names(race_est) %in% c('1:','2:','2+:')]
race_est[-1] <- sapply(race_est[-1], function(x) as.numeric(x))


race_est <- race_est %>% gather(key, population, -C.Block, -Total) %>%
        separate(key, into=c('number.races', 'race'), sep=':') %>%
        mutate(percent.pop = population / Total) %>%
        select(-Total,-population)

write.csv(race_est,file = 'data/SF_census-race.csv')
