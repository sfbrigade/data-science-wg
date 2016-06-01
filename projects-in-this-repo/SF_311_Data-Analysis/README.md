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

### Current Status: June 1, 2016

We've recently finished our statistical tests and presented the answers to our research questions to SF's 311 Deputy Director and Chief Data Officer, although this resulted in having to revisit our tests for predicting cases that would get transferred. Thus, we're revisiting those tests while moving on to reporting, which we hope to finish as quickly as possible.

+ [**Click to view our early exploratory analyses (visuals, summary stats, etc) >>**](/Exploratory_Analyses/)

*What you see below is a foundation for integrating our statistical tests and final reporting.*

### Introduction

+ Intro w/impetus.
+ Acknowledgements.
*Please note: This introduction will soon replace the one above.*

### Literature Review

As a critical connection between municipal resources and needs, 311 call centers have become a vital component of municipal operations for large cities. They also provide a wealth of information on municipal needs, operations, and resources across the urban landscape. The opportunity to delve into this rich data and retrieve actionable insights has already been acted upon by several cities.  

Third parties have taken advantage, using open data portals to access 311 data and tease out insights. A study from New York University used New York City’s 311 data showed that complaints about neighbors are more likely to occur in areas bordering two homogenous communities where ethnic and racial group are not clearly defined. The study used edge-detection algorithms with census data to define ethnically homogenous areas and detect the “fuzziness” of borders between them, then mapped complaint calls to these areas. Another study from scholars at Yale and UC-Berkeley found a positive negative relationship between police stops which turned up no illegal behavior and 311 calls in the area, with its authors concluding that New York City’s controversial stop-and-frisk practices seed a distrust of government which affects 311 usage. After city legislation aimed at noise complaints was introduced, the New Yorker released an analysis of the 311 noise complaints which prompted it, breaking down the noisiest times, days, neighborhoods and differences between noise types.  

Beyond describing human behavior, some cities have taken the next step in turning 311 data into action by connecting information coming from and under the purview of multiple agencies and using predictive models to save time and money for cities. In New York City, a cluster of reports about sanitation concerns or food-borne illness related to a particular restaurant now triggers a quicker response from the health department. The city also prioritizes building inspections by crossing data on landlords delinquent on their property taxes and calls complaining about illegal rental unit conversion. In Buffalo, local law enforcement uses a combination of 311 call data and police report data to more accurately target regular “clean sweeps” to address troubled neighborhoods. These are just a few examples from those cities leading the way in making informed operational changes with 311, but there are a great many opportunities to further exploit open 311 data to improve local government.  

### Methodology

Informed and inspired by its exploratory analyses, the Data Science Working Group sought to answer questions pertaining to 311’s operational concerns, as well as questions the public might have over the City’s equitable treatment of cases, by type and demographic association or deduction. To that end, although the DSWG was able to secure full and filtered datasets on 311 cases, using San Francisco’s celebrated OpenData portal and APIs, our demographic data and the true nature of its association with cases can, at times, result in one or both of the following interpretive limitations:  

1. Our demographic data source was the American Community Survey (ACS), which is akin to an annual “mini census” between the decennial U.S. Censuses. However, due to substantially smaller sample sizes, its margins of error are larger than those of the Census. Still, as the ACS is often considered the gold standard of -freely available- demographic data, from which many public and private institutions draw, the DSWG humbly proposes that the findings herein are at least as reliable as those of public policy studies equally dependent on ACS data. 

2. Crucially, each case’s geographic coordinates are those of the incident/location being reported, not necessarily those of the caller. The researchers’ demographically related tests and interpretations were careful to make that distinction while still managing to draw insights of reasonable interest to the public.

Finally, on the matter of sample sizes per statistical test, where necessary or convenient, the researchers simply employed the entire population of cases (N > 1.6 Million). Such instances were made possible by Microsoft’s kind offering of Azure credits for public good (via its BizSpark program), whereby the DSWG could leverage the computing power of Azure’s Machine Learning Studio while using Jupyter Notebooks (both R and Python kernels). In all other statistical tests, the DSWG opted for a laptop- friendly 5,000 case random sample or some sub-sample of it, as noted per test.

**Data Sources**

+ Full 311 case data pull (7-1-08 through 3-16-16; *please note, both downloads are extremely large!*)
    - [Via API (JSON) >>](https://data.sfgov.org/resource/ktji-gk7t.json$where=date between '2008-07-01T12:00:00' and '2016-03-16T23:00:00')
    - [Download CSV >>](https://data.sfgov.org/api/views/vw6y-z8j6/rows.csv?accessType=DOWNLOAD)
+ [Sample of 311 case data (5000 case random sample of the API data pull above)](https://github.com/sfbrigade/data-science-wg/blob/master/projects-in-this-repo/SF_311_Data-Analysis/data/cases_sample.csv?raw=true)
+ [American Community Survey data (2014; 5 year estimates)](https://github.com/sfbrigade/data-science-wg/tree/master/projects-in-this-repo/SF_311_Data-Analysis/data)


### Research Questions

#### Operational Concerns

1. What case features and/or feature values predict cases that would later become 'invalid'?
2. What case features and/or feature values predict cases that would eventually get transferred?
3. Can we fairly accurately forecast the frequency of one or more request categories from their apparent seasonality?
4. Is there any potential for more responsive reporting tools via app or voice interfaces? (i.e. they change upon meeting one or more conditions)  
    - Can we detect anomalies in frequency of one or more request categories, particularly per geographic location?
5. Has reporting 'homeless concerns' substantially changed since 311 changed its app and voice menus around such reporting?  

#### Equity Concerns

1. Which features of calls (location, request type, source, caselength, etc) are good predictors of income?
2. How are 311 requests distributed across Census block income levels?
3. How are 311 request resolution times distributed across Census block income levels?
4. Is there a correlation between resolution time and percent (%) any racial or ethnic population?

### Conclusion / Implications

#### Public Policy

#### Operations

#### Product Opportunities

#### Future Research

### Appendix
