![](311_explore.jpg)  

## 311 Case Data: Exploratory Analyses

[SF OpenData](https://data.sfgov.org/) provides a real-time record and API for [311 cases completed and in progress](https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6). The Data Science Working Group at Code for San Francisco looks to perform exploratory statistical analyses on this data to see whether it might posses strategically and/or politically interesting characteristics, which we will later confirm -via inferential statistics- and report to relevant stakeholders (e.g. San Francisco's public agencies and/or the publics they serve).  

**Responsible DSWG Teammates**
+ [Matthew Pancia](http://bit.ly/1PFuA8k)
+ [Elena Palesis](http://bit.ly/1mgjXl4)
+ [Yiwen Yu](http://bit.ly/1mgkqDE)
+ [Jude Calvillo](http://linkd.in/1BGeytb)
+ [Jeff Lam](http://bit.ly/1Pm9SLJ)
+ [Matthew Mollison](http://bit.ly/1PPZXSa)

### Current Status: Feb. 11, 2016

Our sample dataset now includes zips and census blocks, per case, in preparation for joining with Census data and running our statistical analyses. To that end, we've now settled on the tests we'd like to perform, some of which span 311 case and Census data, along with some interesting cluster visualizations we wish to produce via 'bigger' data methods.  

We'll be dividing up and executing the above over the next week and expect to share some of our findings + visualizations at [Code for America's upcoing CodeAcross in San Francisco (March 5, 2016)](https://www.codeforamerica.org/events/codeacross-2016/).  

*Please note: This directory's name may soon change, as we're now moving beyond exploratory analyses.*  

### Tests to be Performed

The tests we're currently tackling include:

+ Income correlates / significant diffs?
+ Resolution time (by agency, overall, neighborhood, income, etc)?
+ Neighborhoods per request type?
+ Ethnic correlates / significant diffs?
+ Significant diffs in request types by source?
+ Seasonality to request types?
+ Interaction between call frequency and resolution time, per request type and/or per responsible agency?  
    
### Quickies
These are just some early descriptive plots, until the team begins systematically tackling the statistical analyses mentioned above.   

*Please note, all of the below draw from a 5,000 record sample*:

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-2.png) 

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

### Similarity of Request Type Distributions (K-L Divergence)
The graph below, produced by Matt Pancia, clusters neighborhoods according to the similarity of their request type distributions, as reflected by their [Kullback–Leibler divergence/weight](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence).  

![](figure/kl_divergence_graph.png)  

### Time-Lapse Heatmap of 311 Requests for Sidewalk and Street Cleaning
The heatmap linked to below geographically reflects the number of 311 requests for sidewalk and street cleaning over time. It was produced by Jeffrey Lam and will help inform our impending investigations over seasonality to request types.

[![](figure/cartodb_heatmap_sf-311-calls.jpg)](http://bit.ly/1WnReqW)  

### Resolution Time Exploration (in Hours)
We'll be adding plots later. These are just some summaries to inspire the DSWG's more advanced/inferential statistics.



#### Top 10 Request Types...
**--- By Shortest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                             | Mean.Resolve|
|:--------------------------------------------------------|------------:|
|Sign Repair - Loose                                      |         0.03|
|mta - residential_parking_permit - request_for_service   |         0.04|
|tt_collector - tt_collector - mailing_request            |         0.23|
|puc - water - customer_callback                          |         0.79|
|mta - bicycle - request_for_service                      |         1.20|
|Litter_Receptacle_Request_New_Removal                    |         1.69|
|homeless_concerns - homeless_other - request_for_service |         2.06|
|puc - water - request_for_service                        |         2.12|
|City_garbage_can_overflowing                             |         2.30|
|Illegal Postings - Posting_Too_High_on_Pole              |         3.12|

**--- By Longest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                | Mean.Resolve|
|:-------------------------------------------|------------:|
|dpw - bsm - followup_request                |     27208.90|
|Public_Stairway_Defect                      |     25823.03|
|Streetlight - Other_Request_New_Streetlight |     18549.16|
|Utility Lines/Wires                         |     17381.97|
|rpd - rpd_other - request_for_service       |     11650.02|
|SFHA Priority - Preventive                  |     10512.38|
|sfpd - sfpd - request_for_service           |     10336.51|
|puc - puco - complaint                      |      8905.67|
|dtis - dtis - request_for_service           |      8573.08|
|Streetlight - Other_Request_Light_Shield    |      6312.14|

#### Top 10 Neighborhoods...
**--- By Shortest Mean Resolution Time (across all request types) ---**

|Neighborhood          | Mean.Resolve|
|:---------------------|------------:|
|McLaren Park          |         2.82|
|Candlestick Point SRA |         6.30|
|Parkmerced            |        12.40|
|Merced Manor          |        15.88|
|Sherwood Forest       |        24.13|
|Peralta Heights       |        47.58|
|Alamo Square          |        47.78|
|Little Hollywood      |        48.76|
|Lake Street           |        55.12|
|Balboa Terrace        |        78.03|

**--- By Longest Mean Resolution Time (across all request types) ---**

|Neighborhood        | Mean.Resolve|
|:-------------------|------------:|
|Holly Park          |      2540.00|
|Cole Valley         |      2435.79|
|Cayuga              |      2343.87|
|Anza Vista          |      1736.16|
|Presidio Terrace    |      1541.12|
|Cow Hollow          |      1462.26|
|Glen Park           |      1394.10|
|West of Twin Peaks  |       924.89|
|Northern Waterfront |       887.75|
|Castro/Upper Market |       864.53|







