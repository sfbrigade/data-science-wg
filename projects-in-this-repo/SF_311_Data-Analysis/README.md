![](311_explore.jpg)  

## 311 Case Data: Data Analysis

[SF OpenData](https://data.sfgov.org/) provides a real-time record and API for [311 cases completed and in progress](https://data.sfgov.org/City-Infrastructure/Case-Data-from-San-Francisco-311-SF311-/vw6y-z8j6). The Data Science Working Group at Code for San Francisco looks to perform exploratory statistical analyses on this data to see whether it might posses strategically and/or politically interesting characteristics, which we will later confirm -via inferential statistics- and report to relevant stakeholders (e.g. San Francisco's public agencies and/or the publics they serve).  

**Responsible DSWG Teammates**
+ [Matthew Pancia, Ph.D.](http://bit.ly/1PFuA8k)
+ [Elena Palesis](http://bit.ly/1mgjXl4)
+ [Jude Calvillo (Project Lead)](http://linkd.in/1BGeytb)
+ [Jeff Lam](http://bit.ly/1Pm9SLJ)
+ [Matthew Mollison, Ph.D.](http://bit.ly/1PPZXSa)
+ [Hannah Burak](http://bit.ly/1U7D13N)

### Current Status: July 1, 2016

We've recently finished our statistical tests and presented the answers to our research questions to SF's 311 Deputy Director and Chief Data Officer, although this resulted in having to revisit our tests for predicting cases that would get transferred. Thus, we're revisiting those tests while moving on to reporting, which we hope to finish as quickly as possible.

+ [**Click to view our early exploratory analyses (visuals, summary stats, etc) >>**](https://git.io/viYWh)  
  

### Table of Contents (click to jump)

+ [Introduction](#Intro)
+ [Literature Review](#Literature Review)
+ [Methodology](#Methodology)
    - Data Sources
+ [Research Questions](#Research Questions)
    - Operational Concerns
    - Equity Concerns
+ [Conclusion / Implications](#Conclusion)
    - Public Policy
    - Operations
    - Future Research
+ [Appendix](#Appendix)  


### <a name="Intro">Introduction: It's Coming</a>

+ Intro w/impetus.
+ Acknowledgements.

***

### <a name="Literature Review">Literature Review</a>

As a critical connection between municipal resources and needs, 311 call centers have become a vital component of municipal operations for large cities. They also provide a wealth of information on municipal needs, operations, and resources across the urban landscape. The opportunity to delve into this rich data and retrieve actionable insights has already been acted upon by several cities.  

Third parties have taken advantage, using open data portals to access 311 data and tease out insights. A study from New York University used New York City's 311 data showed that complaints about neighbors are more likely to occur in areas bordering two homogenous communities where ethnic and racial group are not clearly defined.<sup>1</sup> The study used edge-detection algorithms with census data to define ethnically homogenous areas and detect the "fuzziness" of borders between them, then mapped complaint calls to these areas. Another study from scholars at Yale and UC-Berkeley found a positive negative relationship between police stops which turned up no illegal behavior and 311 calls in the area, with its authors concluding that New York City's controversial stop-and-frisk practices seed a distrust of government which affects 311 usage.<sup>2</sup> After city legislation aimed at noise complaints was introduced, the New Yorker released an analysis of the 311 noise complaints which prompted it, breaking down the noisiest times, days, neighborhoods and differences between noise types.<sup>3</sup>  

Beyond describing human behavior, some cities have taken the next step in turning 311 data into action by connecting information coming from and under the purview of multiple agencies and using predictive models to save time and money for cities. In New York City, a cluster of reports about sanitation concerns or food-borne illness related to a particular restaurant now triggers a quicker response from the health department. The city also prioritizes building inspections by crossing data on landlords delinquent on their property taxes and calls complaining about illegal rental unit conversion. In Buffalo, local law enforcement uses a combination of 311 call data and police report data to more accurately target regular 'clean sweeps' to address troubled neighborhoods.<sup>4</sup> These are just a few examples from those cities leading the way in making informed operational changes with 311, but there are a great many opportunities to further exploit open 311 data to improve local government.  

***
<sup>1</sup>New York University, Study Uses 311 Complaints to Track When and Where Neighborhood Conflict Emerges. August 21, 2015   [https://www.nyu.edu/about/news-publications/news/2015/08/21/study-uses-311-complaints-to-track-when-and-where-neighborhood-conflict-emerges.html ](https://www.nyu.edu/about/news-publications/news/2015/08/21/study-uses-311-complaints-to-track-when-and-where-neighborhood-conflict-emerges.html)  
<sup>2</sup>Tuhus-Dubrow, Rebecca, Who is Most Likely to Dial 311? *Next City*,   [https://nextcity.org/daily/entry/who-is-most-likely-dial-311](https://nextcity.org/daily/entry/who-is-most-likely-dial-311)  
<sup>3</sup>Wellington, Ben. Mapping New York’s Noisiest Neighborhoods. *The New Yorker*, January 17, 2015. [http://www.newyorker.com/tech/elements/mapping-new-york-noise-complaints](http://www.newyorker.com/tech/elements/mapping-new-york-noise-complaints)  
<sup>4</sup>Napier, Jessica Renee. Buffalo Uses 311 Data to “Sweep” Neighborhoods. *Government Technology*, June 6, 2013.  
[http://www.govtech.com/technology/Buffalo-Uses-311-Data-to-Sweep-Neighborhoods.html](http://www.govtech.com/technology/Buffalo-Uses-311-Data-to-Sweep-Neighborhoods.html)

***

### <a name="Methodology">Methodology</a>

Informed and inspired by its [exploratory analyses](http://bit.ly/29vOYfi), the Data Science Working Group sought to answer questions pertaining to 311's operational concerns, as well as questions the public might have over the City's equitable treatment of cases, by type and demographic association or deduction. To that end, although the DSWG was able to secure full and filtered datasets on 311 cases, using [San Francisco's celebrated OpenData portal and APIs](https://data.sfgov.org/), our demographic data and the true nature of its association with cases can, at times, result in one or both of the following interpretive limitations:  

1. Our demographic data source was the [American Community Survey (ACS)](https://www.census.gov/programs-surveys/acs/), which is akin to an annual 'mini census' between the decennial U.S. Censuses. However, due to substantially smaller sample sizes, its margins of error are larger than those of the Census. Still, as the ACS is often considered the gold standard of -freely available- demographic data, from which many public and private institutions draw, the DSWG humbly proposes that the findings herein are at least as reliable as those of public policy studies equally dependent on ACS data. 

2. Crucially, each case's geographic coordinates are those of the incident/location being reported, not necessarily those of the caller. The researchers' demographically related tests and interpretations were careful to make that distinction while still managing to draw insights of reasonable interest to the public.

Finally, on the matter of sample sizes per statistical test, where necessary or convenient, the researchers simply employed the entire population of cases (N > 1.6 Million). Such instances were made possible by Microsoft's kind offering of Azure credits for public good (via its BizSpark program), whereby the DSWG could leverage the computing power of Azure's Machine Learning Studio while using Jupyter Notebooks (both R and Python kernels). In all other statistical tests, the DSWG opted for a laptop- friendly 5,000 case random sample or some sub-sample of it, as noted per test.

**Data Sources**

+ Full 311 case data pull (7-1-08 through 3-16-16; *please note, both downloads are extremely large!*)
    - [Via API (JSON) >>](https://data.sfgov.org/resource/ktji-gk7t.json$where=date between '2008-07-01T12:00:00' and '2016-03-16T23:00:00')
    - [Download CSV >>](https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD)
+ [Sample of 311 case data (5000 case random sample of the API data pull above)](https://github.com/sfbrigade/data-science-wg/blob/master/projects-in-this-repo/SF_311_Data-Analysis/data/cases_sample.csv?raw=true)
+ [American Community Survey data (2014; 5 year estimates)](https://github.com/sfbrigade/data-science-wg/tree/master/projects-in-this-repo/SF_311_Data-Analysis/data)

***



### <a name="Research Questions">Research Questions</a>

#### Operational Concerns
These were questions directly posed by SF City gov't leadership or inspired by conversations with them.

**1. What case features and/or feature values predict cases that would later become 'invalid'?**  
+ *Please see status above.*  

**2. For transferred cases, which initial Responsible Agency designations tend to drive transfers to other Responsible Agencies? (i.e. Can 311 better integrate its reporting with one or more Responsible Agencies?)**  
  
+ *In the heatmap below, one can see transferred cases' originally designated Responsible Agencies (Y axis) and the Responsible Agencies they were ultimately transferred to (X axis). Therein, the darker the square at each intersection, the more often a transfer between those intersecting agencies took place, at least according to 311 records.*  
  
+ *It appears, from the heatmap, that MUNI Work Que and 311 Supervisor Queue-originating cases tend to dominate transferred cases, and such cases mostly get transferred to the DPW Ops Que. Interestingly, transferred cases originating from the 311 Supervisor Queue also apparently tend to transfer to the DPT SignShop in Areas 1 or 2.*  

    - *One can see this more clearly in the second heatmap, which isolates transferred cases originating in the 311 Supervisor Queue and then arranges the destination Responsible Agency (X axis) in descending order.*   
  
+ *Please note: all of the values above had to be log transformed for more useful shading, given that the frequency of cases transferred to the DPW Ops Que was so high as to flatten the shading of transfers to all other Responsible Agencies.*  
  
+ *To see the full investigation (by Matt Mollison, Ph.D.), including source code (Python) and comments, [click here.](http://bit.ly/29vPxWy)*  

![](figure/311_transfers_heatmap.png)  

![](figure/311_trans-sup_heatmap.png)
  
**3. Can we fairly accurately forecast the frequency of one or more request categories from their apparent seasonality?**  

+ *Yes. We begun this analysis by simply looking for monthly patterns in the data, per request type, which you can see below, in the case of abandoned vehicle requests.*  

![](figure/season_exploration.png)

+ *Thereafter, we went into full-on seasonal decomposition, across years, for each request category, as such a method helps us extract the detected season (is there a recurring chronological pattern?), detected trend (is the incidence rising or falling?), and residuals within the data (what's outside of the season and trend?). In the example below, we see the seasonal decomposition for Street and Sidewalk Cleaning.*

![](figure/311_seasonal-decomp.png)

+ *And the above is interesting because, with the residuals, we are able to start looking for truely anomalous data points...*  

**4. Can we detect anomalies in frequency of one or more request categories, particularly per geographic location?**  

+ Yes, we can. If one looks at the residuals above, one can begin to see which observations might be anomalous to such seasonally sensitive data. One can then tackle anomaly detection accordingly, via generalized *Extreme Studentized Deviate* test (i.e. *Rosner test* for outliers) upon these outliers, ...or one can simply invoke [Twitter's convenient new anomaly detection package](https://github.com/twitter/AnomalyDetection), which employs the above while also offering optional piecewise appromixation.  

    - The following plot reveals those days that exhibited an anomolous frequency of requests for Street and Sidewalk Cleaning (*more on this later*).
![](figure/311_anomaly-detection.png)

**5. Has reporting 'homeless concerns' substantially changed since 311 changed its app and voice menus around such reporting?**  

+ *Unfortunately, answering this question proved impossible, because, prior to having formalized a category and Responsible Agency for homeless concerns, the reporting and assignment of such requests ran the gamut of possibilities.*  

***

#### Equity Concerns

**1. Which features of cases (location, source, caselength, category) are good predictors of income?**  

+ *Case length: Notably, case length does not predict the request location's median income. Put another way, the City appears to resolve cases across areas (Census Tracts) of varying income levels in roughly the same amount of time, which actually answers our question #3.*
    

```
## 
## Call:
## lm(formula = pc_inc2014 ~ caselength, data = income)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -41432 -16024  -2958  14219  84966 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.967e+04  3.548e+02 139.983   <2e-16 ***
## caselength  -4.577e-02  1.210e-01  -0.378    0.705    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 23690 on 4760 degrees of freedom
##   (222 observations deleted due to missingness)
## Multiple R-squared:  3.008e-05,	Adjusted R-squared:  -0.00018 
## F-statistic: 0.1432 on 1 and 4760 DF,  p-value: 0.7052
```

+ *Source: Source (e.g. app, call, social) does not significantly predict income within our 5,000 case sample, although, as Gregory Dillon has pointed out, it's likely that subsetting to the last two years might reveal some differences (to be investigated soon!).*    
 
    

```
## 
## Call:
## lm(formula = pc_inc2014 ~ Source, data = income)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -41865 -15772  -2465  13502  90995 
## 
## Coefficients:
##                         Estimate Std. Error t value Pr(>|t|)    
## (Intercept)              56582.5    16702.6   3.388  0.00071 ***
## SourceIntegrated Agency -13603.8    16781.9  -0.811  0.41762    
## SourceMail In              137.5    28929.7   0.005  0.99621    
## SourceOpen311            -4996.1    16725.3  -0.299  0.76517    
## SourceOther Department    2833.5    21562.9   0.131  0.89546    
## SourceTwitter           -10544.9    17033.4  -0.619  0.53590    
## SourceVoice In           -7580.8    16707.6  -0.454  0.65004    
## SourceWeb Self Service   -3560.4    16729.0  -0.213  0.83147    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 23620 on 4976 degrees of freedom
## Multiple R-squared:  0.007779,	Adjusted R-squared:  0.006383 
## F-statistic: 5.573 on 7 and 4976 DF,  p-value: 2.062e-06
```

- *And via a color classified scatter plot, below, we're able to visually confirm that case length and income are not correlated, while also distinguishing between source.*

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

+ *Neighborhood: It does appear that cases' corresponding neighborhoods are predictive of income, which is intuitive. However, neighborhood, as a predictor, also happens to explain the -most- variation in income vs. all predictors tested herein, explaining roughly 74% of the variation.*
 
    

```
## [1] "Multiple R-squared (i.e. variance explained): 0.74149"
```

+ *And here are the top 10 neighborhoods most positively predictive of income, in descending order.*


```
##                                Estimate Std. Error   t value      Pr(>|t|)
## Golden Gate Park               85225.02   2068.488 41.201593 2.936924e-319
## Seacliff                       84225.02   3566.680 23.614403 6.571842e-117
## Pacific Heights                65011.98   1437.634 45.221502  0.000000e+00
## Marina                         62316.04   1499.338 41.562364  0.000000e+00
## Financial District/South Beach 62135.80   1242.026 50.027772  0.000000e+00
## Castro/Upper Market            57678.66   1145.931 50.333468  0.000000e+00
## Presidio Heights               56319.33   2092.221 26.918447 4.700468e-149
## Presidio                       56229.02   7021.798  8.007781  1.444625e-15
## Potrero Hill                   53914.74   1590.918 33.889070 1.493178e-226
## Noe Valley                     53703.74   1542.327 34.819954 8.977782e-238
```

+ Category: *Slowly but surely, it's coming.*


```
## 
## Call:
## lm(formula = pc_inc2014 ~ Category, data = income)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -56486 -16915  -2932  11905  88472 
## 
## Coefficients:
##                                      Estimate Std. Error t value Pr(>|t|)
## (Intercept)                           46754.5     3219.6  14.522  < 2e-16
## CategoryAbandoned Vehicle              5769.1     3423.1   1.685 0.091985
## CategoryBlocked Street or SideWalk     6092.6     4599.4   1.325 0.185351
## CategoryCatch Basin Maintenance       11653.1     6439.2   1.810 0.070399
## CategoryColor Curb                     3970.6     8743.4   0.454 0.649758
## CategoryDamaged Property               8649.5     3640.7   2.376 0.017550
## CategoryDPW Volunteer Programs         8110.5    23216.8   0.349 0.726851
## CategoryGeneral Requests               7641.7     3480.0   2.196 0.028146
## CategoryGraffiti Private Property      -621.2     3439.5  -0.181 0.856692
## CategoryGraffiti Public Property       6528.6     3387.7   1.927 0.054015
## CategoryIllegal Postings              13807.2     3918.3   3.524 0.000429
## CategoryInterdepartmental Request     -7194.3    11938.5  -0.603 0.546797
## CategoryLitter Receptacles             2358.7     3912.3   0.603 0.546614
## CategoryMUNI Feedback                   829.3     4272.7   0.194 0.846110
## CategoryNoise Report                   9371.5    16573.8   0.565 0.571801
## CategoryRec and Park Requests         23698.6     4130.1   5.738 1.01e-08
## CategoryResidential Building Request  -7277.9     5775.0  -1.260 0.207641
## CategorySewer Issues                   7233.1     3654.1   1.979 0.047820
## CategorySFHA Requests                -11777.3     3632.2  -3.242 0.001193
## CategorySidewalk or Curb               6087.2     4173.1   1.459 0.144715
## CategorySign Repair                   11225.8     3900.7   2.878 0.004021
## CategoryStreet and Sidewalk Cleaning  -1252.5     3266.0  -0.383 0.701375
## CategoryStreet Defects                 4370.3     3820.3   1.144 0.252697
## CategoryStreetlights                   2370.0     3739.9   0.634 0.526296
## CategoryTemporary Sign Request        19133.9     4489.5   4.262 2.06e-05
## CategoryTree Maintenance               6046.3     3820.3   1.583 0.113561
##                                         
## (Intercept)                          ***
## CategoryAbandoned Vehicle            .  
## CategoryBlocked Street or SideWalk      
## CategoryCatch Basin Maintenance      .  
## CategoryColor Curb                      
## CategoryDamaged Property             *  
## CategoryDPW Volunteer Programs          
## CategoryGeneral Requests             *  
## CategoryGraffiti Private Property       
## CategoryGraffiti Public Property     .  
## CategoryIllegal Postings             ***
## CategoryInterdepartmental Request       
## CategoryLitter Receptacles              
## CategoryMUNI Feedback                   
## CategoryNoise Report                    
## CategoryRec and Park Requests        ***
## CategoryResidential Building Request    
## CategorySewer Issues                 *  
## CategorySFHA Requests                ** 
## CategorySidewalk or Curb                
## CategorySign Repair                  ** 
## CategoryStreet and Sidewalk Cleaning    
## CategoryStreet Defects                  
## CategoryStreetlights                    
## CategoryTemporary Sign Request       ***
## CategoryTree Maintenance                
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 22990 on 4958 degrees of freedom
## Multiple R-squared:  0.06328,	Adjusted R-squared:  0.05856 
## F-statistic:  13.4 on 25 and 4958 DF,  p-value: < 2.2e-16
```
  
  
  
**2. How is 311 request volume distributed across Census tract income levels?**  

+ *The vast majority of 311 request locations belong to Census tracts with household income levels below $100k/year.*

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png)

**3. How are 311 request resolution times distributed across Census tract income levels?**  

+ *This was effectively answered in our first regression (q. 1), on case length, but just to reiterate: the City appears to resolve cases across areas (Census Tracts) of varying income levels in roughly the same amount of time, which actually answers our question #3.*
    

```
## 
## Call:
## lm(formula = pc_inc2014 ~ caselength, data = income)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -41432 -16024  -2958  14219  84966 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.967e+04  3.548e+02 139.983   <2e-16 ***
## caselength  -4.577e-02  1.210e-01  -0.378    0.705    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 23690 on 4760 degrees of freedom
##   (222 observations deleted due to missingness)
## Multiple R-squared:  3.008e-05,	Adjusted R-squared:  -0.00018 
## F-statistic: 0.1432 on 1 and 4760 DF,  p-value: 0.7052
```

**4. Is there a correlation between resolution time and percent (%) any racial or ethnic population?**

### <a name="Conclusion">Conclusion / Implications</a>

#### Public Policy

Overall, there are two ways one can view the public policy insights and implications... 

#### Operations

It appears 311's operations can make some respectable efficiency gains from the insights above. Although the picture for predicting which kinds of cases might ultimately become _invalid_ is murky, at least in practical terms, the picture for which cases might ultimately get _transferred_ is reasonably clear.

**Product Opportunities**

#### Future Research



### <a name="Appendix">Appendix</a>
