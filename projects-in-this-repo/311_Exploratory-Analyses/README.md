![](311_explore.jpg)  

## 311 Case Data: Exploratory Analyses

[SF OpenData](https://data.sfgov.org/) provides a real-time record and API for [311 cases completed and in progress](https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6). The Data Science Working Group at Code for San Francisco looks to perform exploratory statistical analyses on this data to find whether there are any strategically and/or politically interesting characteristics of San Francisco's public agencies and/or the publics they serve.  

**Responsible DSWG Teammates**
+ [Matthew Pancia](http://bit.ly/1PFuA8k)
+ [Elena Palesis](http://bit.ly/1mgjXl4)
+ [Yiwen Yu](http://bit.ly/1mgkqDE)
+ [Jude Calvillo](http://linkd.in/1BGeytb)
+ [Jeff Lam](http://bit.ly/1Pm9SLJ)
+ [Catherine Zhang](http://bit.ly/1WXteM8)
+ [Rocio Ng](http://bit.ly/1WXtj2v)
+ [Abhiram Chintangal](http://bit.ly/1WXtpHr)

### Tests to be Performed
These have yet to be determined, but some analyses we're currently considering include:

+ Looking for statistically significant differences in...
    - Resolution times by agency (overall and per request type)
    - Resolution times by neighborhood served (overall and per request type)
    - Resolution times by Supervisor/District (overall and per request type)
    - Request types per neighborhood
+ Correlations between...
    - Resolution times and call frequency
    
### Quickies
Just some basic descriptive stats and plots until the team begins its real statistical analyses. *Please note, all of the below draw from a 5,000 record sample*:

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-2.png) 

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

### Resolution Time Explorations (in Hours)
We'll be adding plots shortly. These are just some summaries to inspire the DSWG's more advanced/inferential statistics.



#### Top 10 Request Types...
**--- By Shortest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                                      | Mean.Resolve|
|:-----------------------------------------------------------------|------------:|
|Human/Animal Waste                                                |         0.17|
|puc - water - complaint                                           |         0.20|
|rpd - neighborhood_services - compliment                          |         0.29|
|aging_adult_services - aging_adult_services - request_for_service |         0.33|
|Sign - Incorrect_Signage                                          |         0.66|
|Graffiti_Watch                                                    |         0.68|
|dpw - bses - other                                                |         0.92|
|Building - Kitchen_Community                                      |         1.14|
|Trees - Property_damage                                           |         1.22|
|Building - Plumbing_Broken_leaking                                |         1.36|

**--- By Longest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                           | Mean.Resolve|
|:------------------------------------------------------|------------:|
|Out_of_Town_Cab Picking_Up_Passengers                  |     31919.08|
|Unpermitted_Cab Picking_Up_Passengers                  |     24080.41|
|Streetlight - Pole_Cover_Missing                       |     20831.69|
|dpw - buf - followup_request                           |     16581.42|
|dpw - buf - other                                      |     13992.27|
|Sign - Painted_Over                                    |     10523.53|
|Streetlight - Light_Glass_Cover_Missing                |      8720.79|
|Sign Repair - Not_Visible                              |      8537.12|
|Temporary Sign Request for City_Sponsored_Celebrations |      7801.99|
|Streetlight - Pole_Leaning                             |      7723.58|

#### Top 10 Neighborhoods...
**--- By Shortest Mean Resolution Time (across all request types) ---**

|Neighborhood             | Mean.Resolve|
|:------------------------|------------:|
|Yerba Buena Island       |        22.16|
|University Mound         |        45.75|
|Anza Vista               |        48.43|
|Silver Terrace           |        76.21|
|Midtown Terrace          |        85.63|
|Dogpatch                 |        89.19|
|St. Francis Wood         |        95.29|
|Produce Market           |       107.61|
|Aquatic Park / Ft. Mason |       148.78|
|Westwood Park            |       161.75|

**--- By Longest Mean Resolution Time (across all request types) ---**

|Neighborhood        | Mean.Resolve|
|:-------------------|------------:|
|Ingleside Terraces  |      4374.01|
|Little Hollywood    |      2773.60|
|Northern Waterfront |      1844.63|
|Cow Hollow          |      1748.35|
|Monterey Heights    |      1402.66|
|Peralta Heights     |      1339.80|
|Balboa Terrace      |      1329.78|
|Treasure Island     |      1177.88|
|Holly Park          |       940.50|
|Miraloma Park       |       807.97|







