![](drain-flooding-prediction_data-science.jpg)

## Introduction

The *Drain Flooding Prediction* initiative at the [*Data Science Working Group*](https://github.com/sfbrigade/data-science-wg) aims to accurately predict whether a San Francisco drain, or set of drains, will flood on a given day or day + time, based on some mix of features drawn from publicly available datasets.  

If/when successful, the resulting model will likely be integrated into CfSF's larger [*Adopt-a-Drain application*](https://github.com/sfbrigade/adopt-a-drain/) and/or will likely be used by the city to more efficiently allocate its P.U.C. resources. The team also hopes that the resulting model will be flexible enough to adapt -or outright deploy- for other cities.  

### Responsible DSWG Teammates

+ [Matthew Pancia](http://bit.ly/1PFuA8k)
+ [Jude Calvillo](http://linkd.in/1BGeytb)
+ [Elena Palesis](http://bit.ly/1mgjXl4)
+ [Kasia Rachuta](http://bit.ly/1URzpQs)

### Status: As of Feb. 5, 2016

+ Promising datasets and features identified
+ Data munging and model exploration underway

#### Datasets currently being considered:
+ Outcome: 
    - Past P.U.C. calls for flooding and/or drain cleaning ([311 case data](https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6)).
+ Potential predictors:
    - Local precipitation readings ([Open Weather Map API](http://openweathermap.org/), [Weather Underground API](http://www.wunderground.com/weather/api), [NOAA API](http://www.ncdc.noaa.gov/cdo-web/webservices/v2))
    - [Tree species and locations](https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq)
    - [Street sweeping schedules by location](https://data.sfgov.org/City-Infrastructure/Street-Sweeper-Scheduled-Routes-Zipped-Shapefile-F/wwci-6uqu)

