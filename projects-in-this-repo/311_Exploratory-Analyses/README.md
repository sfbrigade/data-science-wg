![](311_explore.jpg)  

## 311 Case Data: Exploratory Analyses

[SF OpenData](https://data.sfgov.org/) provides a real-time record and API for [311 cases completed and in progress](https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6). The Data Science Working Group at Code for San Francisco looks to perform exploratory statistical analyses on this data to find whether there are any strategically and/or politically interesting characteristics of San Francisco's public agencies and/or the publics they serve.  

**Responsible DSWG Teammates**
+ [Catherine Zhang](http://bit.ly/1WXteM8)
+ [Rocio Ng](http://bit.ly/1WXtj2v)
+ [Abhiram Chintangal](http://bit.ly/1WXtpHr)
+ [Jude Calvillo](http://linkd.in/1BGeytb)

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

### Resolution Time Explorations
We'll be adding plots shortly. These are just some summaries to inspire the DSWG's more advanced/inferential statistics.



#### Top 10 Request Types...
**--- By Shortest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                             |Mean.Resolve |
|:--------------------------------------------------------|:------------|
|Sign Repair - Loose                                      |0.03 hours   |
|mta - residential_parking_permit - request_for_service   |0.04 hours   |
|tt_collector - tt_collector - mailing_request            |0.23 hours   |
|county_clerk - county_clerk - request_for_service        |0.51 hours   |
|puc - water - customer_callback                          |0.79 hours   |
|mta - bicycle - request_for_service                      |1.20 hours   |
|Construction Zone Tow-away Permits for Proven Managment  |1.68 hours   |
|Litter_Receptacle_Request_New_Removal                    |1.69 hours   |
|homeless_concerns - homeless_other - request_for_service |2.06 hours   |
|puc - water - request_for_service                        |2.12 hours   |

**--- By Longest Mean Resolution Time (across all neighborhoods) ---**

|Request.Type                                |Mean.Resolve   |
|:-------------------------------------------|:--------------|
|dpw - bsm - followup_request                |27208.90 hours |
|Public_Stairway_Defect                      |25823.03 hours |
|Streetlight - Other_Request_New_Streetlight |18549.16 hours |
|Utility Lines/Wires                         |17381.97 hours |
|rpd - rpd_other - request_for_service       |11650.02 hours |
|SFHA Priority - Preventive                  |10512.38 hours |
|sfpd - sfpd - request_for_service           |10336.51 hours |
|puc - puco - complaint                      |8905.67 hours  |
|dtis - dtis - request_for_service           |8573.08 hours  |
|Streetlight - Other_Request_Light_Shield    |6312.14 hours  |

#### Top 10 Neighborhoods...
**--- By Shortest Mean Resolution Time (across all request types) ---**

|Neighborhood          |Mean.Resolve |
|:---------------------|:------------|
|McLaren Park          |2.82 hours   |
|Candlestick Point SRA |6.30 hours   |
|Parkmerced            |12.40 hours  |
|Merced Manor          |15.88 hours  |
|Sherwood Forest       |24.13 hours  |
|Peralta Heights       |47.58 hours  |
|Alamo Square          |47.78 hours  |
|Little Hollywood      |48.76 hours  |
|Lake Street           |55.12 hours  |
|Balboa Terrace        |78.03 hours  |

**--- By Longest Mean Resolution Time (across all request types) ---**

|Neighborhood        |Mean.Resolve  |
|:-------------------|:-------------|
|Holly Park          |2540.00 hours |
|Cole Valley         |2435.79 hours |
|Cayuga              |2343.87 hours |
|Anza Vista          |1736.16 hours |
|Presidio Terrace    |1541.12 hours |
|Cow Hollow          |1462.26 hours |
|Glen Park           |1394.10 hours |
|West of Twin Peaks  |948.83 hours  |
|Northern Waterfront |887.75 hours  |
|Castro/Upper Market |875.78 hours  |

#### Top 10 Neighborhoods, by Longest Mean Resolution Time for Selected Request Types
**--- For Street Cleaning ---**

|Neighborhood        |Mean.Resolve  |
|:-------------------|:-------------|
|Inner Sunset        |1147.13 hours |
|Castro/Upper Market |900.10 hours  |
|West of Twin Peaks  |305.28 hours  |
|Seacliff            |264.89 hours  |
|Bayview             |161.79 hours  |
|Excelsior           |99.47 hours   |
|Outer Richmond      |96.05 hours   |
|Outer Sunset        |81.76 hours   |
|North Beach         |79.34 hours   |
|Chinatown           |69.72 hours   |

**--- For Sidewalk Cleaning ---**

|Neighborhood          |Mean.Resolve |
|:---------------------|:------------|
|Downtown/Civic Center |305.20 hours |
|Potrero Hill          |274.37 hours |
|Haight Ashbury        |264.27 hours |
|South of Market       |237.16 hours |
|Pacific Heights       |205.75 hours |
|Outer Richmond        |202.23 hours |
|Parkside              |197.74 hours |
|Russian Hill          |196.18 hours |
|Outer Mission         |155.57 hours |
|North Beach           |154.73 hours |



